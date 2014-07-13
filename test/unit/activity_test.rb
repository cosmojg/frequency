# == Schema Information
#
# Table name: activities
#
#  id                    :integer          not null, primary key
#  activity_creator_id   :integer
#  activity_creator_type :string(255)
#  user_id               :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
