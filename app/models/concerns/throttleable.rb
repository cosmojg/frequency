# Allows any user created content to be throttled. Mix this into
# any model that should be limited.
# Note: The model needs to have a user attribute, or this won't work
module Throttleable
  extend ActiveSupport::Concern
  include ActionView::Helpers::DateHelper

  included do
    @@_timeout = 30.minutes
    before_create :check_throttle_expiration
    after_create :add_throttle

    # Overrides the throttle time limit
    # Ex: throttle 30.minutes
    def self.throttle(time)
      @@_timeout = time
    end

    def check_throttle_expiration
      throttle = Throttle.where(user_id: user.id, model: self.class.name).first
      unless throttle.nil?
        if throttle.created_at > @@_timeout.ago
          expiration = throttle.created_at + @@_timeout
          expiration_text = distance_of_time_in_words_to_now(expiration, true)
          errors[:base] << "Slow down there, buddy. Please try again in #{expiration_text}."
          return false
        end
      end
    end

    def add_throttle
      Throttle.where(user_id: user.id, model: self.class.name).delete_all
      Throttle.create(user_id: user.id, model: self.class.name)
    end
  end
end