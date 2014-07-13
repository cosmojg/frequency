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

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
