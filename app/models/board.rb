# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  title      :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Board < ActiveRecord::Base
  attr_accessible :title
  attr_readonly :id

  has_many :conversations, dependent: :destroy
  has_many :unread_states, through: :conversations

end
