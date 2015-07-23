class ChangeMessageBodyToString < ActiveRecord::Migration
  def change
    change_column :messages, :message_body, :string
  end
end
