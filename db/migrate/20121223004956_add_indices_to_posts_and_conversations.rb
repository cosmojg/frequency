class AddIndicesToPostsAndConversations < ActiveRecord::Migration
  def change
    add_index :posts, :conversation_id
    add_index :posts, :user_id

    add_index :conversations, :board_id
    add_index :conversations, :user_id
  end
end
