class AddAttachmentPdfToNews < ActiveRecord::Migration
  def self.up
    change_table :news do |t|
      t.attachment :pdf
    end
  end

  def self.down
    remove_attachment :news, :pdf
  end
end
