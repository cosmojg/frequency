# == Schema Information
#
# Table name: blogs
#
#  id                  :integer          not null, primary key
#  title               :string(255)
#  body                :text
#  user_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  banner_file_name    :string(255)
#  banner_content_type :string(255)
#  banner_file_size    :integer
#  banner_updated_at   :datetime
#

require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
