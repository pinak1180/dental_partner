class SendPushToRecipient < ActiveRecord::Migration
  def change
    add_column :news, :send_push, :boolean, default: false
    add_column :forums, :send_push, :boolean, default: false
    add_column :surveys, :send_push, :boolean, default: false
    add_column :messages, :send_push, :boolean, default: false
  end
end
