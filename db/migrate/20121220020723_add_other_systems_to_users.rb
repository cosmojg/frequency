class AddOtherSystemsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :xbox_live, :string
    add_column :users, :psn, :string
    add_column :users, :steam, :string
  end
end
