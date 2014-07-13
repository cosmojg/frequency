class UpdatePostCountCache < ActiveRecord::Migration
  def up
    User.reset_column_information
    User.select(:id).find_each do |p|
      User.reset_counters p.id, :posts
    end
    Conversation.reset_column_information
    Conversation.select(:id).find_each do |p|
      Conversation.reset_counters p.id, :posts
    end
  end

  def down
  end
end
