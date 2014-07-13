class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :id
      t.integer :user_id
      t.integer :conversation_id
      t.text :body

      t.timestamps
    end
  end
end
