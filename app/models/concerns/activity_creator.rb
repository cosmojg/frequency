module ActivityCreator
  extend ActiveSupport::Concern

  included do
    has_many :activity, as: :activity_creator, dependent: :destroy

    after_create :create_activity
  end

  def create_activity
    puts self.attributes
    Activity.create(activity_creator: self, user: self.user)
  end
end