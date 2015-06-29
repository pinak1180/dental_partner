class AddReceiverToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :direct_user_ids, :integer,  array: true, default: []
  end
end
