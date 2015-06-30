class AddSendToAllToNews < ActiveRecord::Migration
  def change
    add_column :news, :send_to_all, :boolean, default: false
    add_column :forums, :send_to_all, :boolean, default: false
    add_column :surveys, :send_to_all, :boolean, default: false
    add_column :messages, :send_to_all, :boolean, default: false
  end
end
