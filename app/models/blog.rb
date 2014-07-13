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

class Blog < ActiveRecord::Base
  attr_accessible :body, :title, :banner, :user_id
  attr_readonly :id

  belongs_to :user

  acts_as_votable

  has_attached_file :banner
  validates_attachment :banner, :presence => true
  validates_attachment_size :banner, :less_than => 500.kilobytes
  validates_attachment_content_type :banner, :content_type => /image/ 

  validates_presence_of :title, :body, :user_id
end
