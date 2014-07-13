class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :id
      t.string :title
      t.integer :user_id
      t.string :photo_url

      t.timestamps
    end
  end
end
