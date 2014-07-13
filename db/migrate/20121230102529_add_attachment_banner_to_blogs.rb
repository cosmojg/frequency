class AddAttachmentBannerToBlogs < ActiveRecord::Migration
  def self.up
    change_table :blogs do |t|
      t.has_attached_file :banner
    end
  end

  def self.down
    drop_attached_file :blogs, :banner
  end
end
