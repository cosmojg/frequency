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

require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
