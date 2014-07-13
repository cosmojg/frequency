class Throttle < ActiveRecord::Base
  attr_accessible :model, :user_id

  belongs_to :user

end
