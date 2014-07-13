# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  username             :string(255)
#  email                :string(255)
#  crypted_password     :string(255)
#  password_salt        :string(255)
#  persistence_token    :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  avatar_file_name     :string(255)
#  avatar_content_type  :string(255)
#  avatar_file_size     :integer
#  avatar_updated_at    :datetime
#  wiiu_id              :string(255)
#  xbox_live            :string(255)
#  psn                  :string(255)
#  steam                :string(255)
#  friendcode           :string(255)
#  login_count          :integer          default(0), not null
#  failed_login_count   :integer          default(0), not null
#  last_request_at      :datetime
#  current_login_at     :datetime
#  last_login_at        :datetime
#  current_login_ip     :string(255)
#  last_login_ip        :string(255)
#  last_unread_check_at :datetime
#  role                 :string(255)
#

class User < ActiveRecord::Base
  #include ActivityCreator

  attr_accessible :avatar
  attr_protected :crypted_password, :email, :password_salt,
    :persistence_token, :username, :role
  acts_as_authentic
  acts_as_voter

  has_attached_file :avatar, :styles => { :medium => ["300x300>", :png], :thumb => ["100x100>", :png] },
                              :default_url => "default-avatar.png"
  validates_attachment_content_type :avatar, :content_type => /image/
  validates_attachment_size :avatar, :less_than => 500.kilobytes

  has_many :unread_states, dependent: :destroy
  has_many :activity, dependent: :destroy
  has_many :posts
  has_many :pictures

  def self.find_by_username_or_email(login)
    User.find_by_username(login) || User.find_by_email(login)
  end

  def get_unread_count_for(board)
    unread_states.joins(:board).where("boards.id = ?", board.id).count
  end

  def moderator?
    role == "moderator"
  end

  def admin?
    puts role
    role == "admin"
  end
end
