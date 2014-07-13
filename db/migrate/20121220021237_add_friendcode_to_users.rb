class AddFriendcodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :friendcode, :string
  end
end
