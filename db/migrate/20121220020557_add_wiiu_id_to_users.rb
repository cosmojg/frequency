class AddWiiuIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wiiu_id, :string
  end
end
