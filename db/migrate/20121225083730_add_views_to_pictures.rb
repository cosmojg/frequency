class AddViewsToPictures < ActiveRecord::Migration
  def up
    add_column :pictures, :views, :integer, null: false, default: 0
  end

  def down
    remove_column :pictures, :views
  end
end
