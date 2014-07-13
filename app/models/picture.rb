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

class Picture < ActiveRecord::Base
  include ActivityCreator
  #include Throttleable

  attr_accessible :photo_url, :title, :caption
  attr_readonly :id
  attr_protected :user_id, :views

  acts_as_votable

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_attached_file :photo_url, :styles => { :medium => ["300x300>", :jpg] },
    :convert_options => { :all => '-background white -flatten +matte'}

  validates_presence_of :title

  validates_attachment :photo_url, :presence => true
  validates_attachment_size :photo_url, :less_than => 2.megabytes
  validates_attachment_content_type :photo_url, :content_type => /image/

  #throttle 3.minutes

end
