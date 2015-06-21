class AddDeviceFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :device_id, :string
    add_column :users, :device_type, :string
  end
end
