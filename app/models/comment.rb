# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  picture_id :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  include ActivityCreator
  
  attr_accessible :body
  attr_readonly :id
  attr_protected :user_id, :picture_id

  acts_as_votable

  belongs_to :user
  belongs_to :picture
  validates_presence_of :body
  
end
