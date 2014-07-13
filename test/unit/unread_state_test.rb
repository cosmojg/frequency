# == Schema Information
#
# Table name: unread_states
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  conversation_id :integer
#  after           :datetime
#

require 'test_helper'

class UnreadStateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
