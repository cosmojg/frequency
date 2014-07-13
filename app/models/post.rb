# == Schema Information
#
# Table name: posts
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  conversation_id    :integer
#  body               :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  cached_votes_total :integer          default(0)
#  cached_votes_up    :integer          default(0)
#  cached_votes_down  :integer          default(0)
#

class Post < ActiveRecord::Base
  include ActivityCreator
  #include Throttleable

  attr_accessible :body
  attr_protected :conversation_id, :user_id
  attr_readonly :id

  acts_as_votable

  belongs_to :conversation, counter_cache: true
  belongs_to :user, counter_cache: true
  validates_presence_of :body

  after_create :update_conversation_last_reply

  before_destroy :not_first_post
  after_destroy :update_conversation_last_reply

  #throttle 15.seconds

  def self.order_by_created_at
    order("created_at asc")
  end

  # Override create_activity from ActivityCreator to not create an activity for the
  # first post in a thread
  def create_activity
    if self != conversation.first_post
      super
    end
  end

  def page_number
    post_number = conversation.posts.order("created_at asc").index(self)
    (post_number / 20) + 1
  end

  private

  def update_conversation_last_reply
    # TODO: if we're using after_create, we don't need to get the last post to get the date
    # TODO: If we're deleting the conversation, we don't need to update last_reply_at
    conversation.last_reply_at = conversation.last_post.created_at
    conversation.save  # RESEARCH: If this fails, does the entire transaction stop?
  end

  def not_first_post
    if self == conversation.first_post
      errors[:base] << "You cannot delete the first post of a conversation"
      return false  # stop the destroy event
    end

    true
  end
end
