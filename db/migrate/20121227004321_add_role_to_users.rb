class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string

    if User.exists?
      first = User.first
      first.role = "admin"
      first.save!
    end
  end

  def down
    remove_column :users, :role
  end
end
