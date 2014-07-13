class AddLastUnreadCheckToUsers < ActiveRecord::Migration
  def up
    add_column :users, :last_unread_check_at, :datetime
  end

  def down
    remove_column :users, :last_unread_check_at
  end
end
