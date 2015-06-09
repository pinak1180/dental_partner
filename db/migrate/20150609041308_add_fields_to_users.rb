class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :access_level_ids, :integer, array: true, default: []
    add_column :users, :position_ids, :integer, array: true, default: []
    add_column :users, :department_ids, :integer, array: true, default: []
    add_column :users, :practise_code_ids, :integer, array: true, default: []
    add_column :users, :direct_report_ids, :integer, array: true, default: []

    add_index :users, :access_level_ids, using: 'gin'
    add_index :users, :position_ids, using: 'gin'
    add_index :users, :department_ids, using: 'gin'
    add_index :users, :direct_report_ids, using: 'gin'
  end
end
