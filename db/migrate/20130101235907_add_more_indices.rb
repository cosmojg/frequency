class AddMoreIndices < ActiveRecord::Migration
  def change
    add_index :posts, :created_at

    add_index :pictures, :created_at
    add_index :pictures, :user_id

    add_index :comments, :picture_id
  end
end
