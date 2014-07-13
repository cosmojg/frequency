# == Schema Information
#
# Table name: unread_states
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  conversation_id :integer
#  after           :datetime
#

class UnreadState < ActiveRecord::Base
  attr_accessible :after, :conversation_id, :user_id

  belongs_to :user
  belongs_to :conversation
  has_one :board, through: :conversation
end
