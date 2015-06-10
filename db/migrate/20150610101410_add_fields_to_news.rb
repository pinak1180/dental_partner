class AddFieldsToNews < ActiveRecord::Migration
  def change
    add_column :news, :access_level_ids, :integer, array: true, default: []
    add_column :news, :position_ids, :integer, array: true, default: []
    add_column :news, :department_ids, :integer, array: true, default: []
    add_column :news, :practise_code_ids, :integer, array: true, default: []
    add_column :news, :direct_report_ids, :integer, array: true, default: []

    add_index :news, :access_level_ids, using: 'gin'
    add_index :news, :position_ids, using: 'gin'
    add_index :news, :department_ids, using: 'gin'
    add_index :news, :direct_report_ids, using: 'gin'
  end
end
