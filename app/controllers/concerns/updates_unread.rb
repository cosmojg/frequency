module UpdatesUnread
  extend ActiveSupport::Concern

  included do
    before_filter :update_unread
  end

  # Create unread state flags for every newly created conversation
  def update_unread
    return unless current_user

    # Note: This could probably have been done in a single query, but I'm not
    # aware of how to do that yet with ActiveRecord
    last_check = current_user.last_unread_check_at
    new_conversations = Conversation.where("last_reply_at >= ?", last_check)

    # create the unread states
    new_conversations.each do |conversation|
      unless conversation.unread_for? current_user
        UnreadState.create(user_id: current_user.id,
            conversation_id: conversation.id, after: last_check)
      end
    end

    # Update the last check time
    now = ActiveRecord::Base.default_timezone == :utc ? Time.now.utc : Time.now
    current_user.last_unread_check_at = now
    current_user.save
  end

end