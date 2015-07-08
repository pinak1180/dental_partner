class AddAttachmentMsgAttachmentToMessages < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.attachment :msg_attachment
    end
  end

  def self.down
    remove_attachment :messages, :msg_attachment
  end
end
