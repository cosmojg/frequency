class AddLastReplyAtToConversations < ActiveRecord::Migration
  def up
    add_column :conversations, :last_reply_at, :datetime

    Conversation.all.each do |conversation|
      conversation.last_reply_at = conversation.last_post.created_at
      conversation.save!
    end
  end

  def down
    remove_column :conversations, :last_reply_at
  end
end
