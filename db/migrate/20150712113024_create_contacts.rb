class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.integer :access_level_ids, array: true, default: []
      t.integer :position_ids, array: true, default: []
      t.integer :department_ids, array: true, default: []
      t.integer :practise_code_ids, array: true, default: []
      t.integer :direct_report_ids, :integer, array: true, default: []

      t.timestamps null: false
    end

    add_index :contacts, :access_level_ids, using: 'gin'
    add_index :contacts, :position_ids, using: 'gin'
    add_index :contacts, :department_ids, using: 'gin'
    add_index :contacts, :direct_report_ids, using: 'gin'
  end
end
