class CreateUnreadStates < ActiveRecord::Migration
  def change
    create_table :unread_states do |t|
      t.integer :user_id
      t.integer :conversation_id
      t.datetime :after
    end

    add_index :unread_states, :user_id
    add_index :unread_states, :conversation_id
  end
end
