class AddFieldsToUser1 < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :fax_no, :string

  end
end
