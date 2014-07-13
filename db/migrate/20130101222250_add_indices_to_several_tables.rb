class AddIndicesToSeveralTables < ActiveRecord::Migration
  def change
    add_index :conversations, :last_reply_at

    add_index :users, :last_request_at
    add_index :activities, :created_at
    add_index :blogs, :created_at
  end
end
