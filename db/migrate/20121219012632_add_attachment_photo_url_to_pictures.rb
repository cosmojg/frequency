class AddAttachmentPhotoUrlToPictures < ActiveRecord::Migration
  def self.up
    change_table :pictures do |t|
      t.has_attached_file :photo_url
    end
  end

  def self.down
    drop_attached_file :pictures, :photo_url
  end
end
