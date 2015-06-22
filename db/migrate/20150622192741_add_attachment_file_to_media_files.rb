class AddAttachmentFileToMediaFiles < ActiveRecord::Migration
  def self.up
    change_table :media_files do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :media_files, :file
  end
end
