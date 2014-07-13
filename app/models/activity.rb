# == Schema Information
#
# Table name: activities
#
#  id                    :integer          not null, primary key
#  activity_creator_id   :integer
#  activity_creator_type :string(255)
#  user_id               :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Activity < ActiveRecord::Base
  attr_accessible :activity_creator_id, :activity_creator_type, :user_id
  attr_protected :id

  belongs_to :activity_creator, polymorphic: true
  belongs_to :user

  # TODO: Use the activity creators to generate the message
  def message
    creator = activity_creator
    user_link = fake_link user.username
    if creator.instance_of? Conversation
      user_link + " started a conversation called " + fake_link(creator.title)
    elsif creator.instance_of? Post
      user_link + " posted a reply to " + fake_link(creator.conversation.title)
    elsif creator.instance_of? Picture
      user_link + " shared a picture titled " + fake_link(creator.title)
    elsif creator.instance_of? Comment
      user_link + " commented on a picture called " + fake_link(creator.picture.title)
    else
      user_link + " created an unknown activity related to a " + creator.class.name
    end
  end

  private

  def fake_link(content)
    content = ERB::Util.html_escape content
    "<span class=fake-link>#{content}</span>"
  end

end
