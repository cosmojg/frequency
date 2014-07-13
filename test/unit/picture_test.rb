# == Schema Information
#
# Table name: pictures
#
#  id                     :integer          not null, primary key
#  title                  :string(255)
#  user_id                :integer
#  photo_url              :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  photo_url_file_name    :string(255)
#  photo_url_content_type :string(255)
#  photo_url_file_size    :integer
#  photo_url_updated_at   :datetime
#  caption                :text
#  views                  :integer          default(0), not null
#

require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
