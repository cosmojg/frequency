# == Schema Information
#
# Table name: conversations
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  board_id      :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  last_reply_at :datetime
#

class Conversation < ActiveRecord::Base
  include ActivityCreator

  attr_accessible :title
  attr_protected :board_id, :user_id, :last_reply_at
  attr_readonly :id

  has_many :posts, dependent: :destroy
  has_many :unread_states, dependent: :delete_all

  belongs_to :user
  belongs_to :board

  validates_presence_of :title, maximum: 50

  def self.order_by_last_reply
    order("last_reply_at desc")
  end

  def first_post
    posts.order_by_created_at.first
  end

  def last_post
    posts.order_by_created_at.last
  end

  # Whenever conversation updates, we also want to update the first post at the same
  # time. This is a really terrible solution, but I don't know any other way to
  # save this and the first post simultaneously in a safe manner
  def save_self_and_post(post)
    begin
      transaction do
        # Call this so that this conversation's error attribute gets populated
        # properly. This covers cases where both the title and the post body are invalid
        valid?

        post.save!
        save!
      end
    rescue ActiveRecord::RecordInvalid => invalid
      return false
    end

    true
  end

  # Returns whether or not this conversation is unread for the given user
  # Note: This way of doing it is suboptimal. It'd be better to implement
  # a "self.with_unread_state" scope that does a join
  def unread_for?(user)
    if user
      unread_states.where(user_id: user.id).exists?
    else
      false
    end
  end

end
