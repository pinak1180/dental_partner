class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :message_body
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :is_deleted, default: false
      t.boolean :is_read, default: false
      t.integer :parent_id
      t.integer :position_ids,      array: true, default: []
      t.integer :department_ids,    array: true, default: []
      t.integer :practise_code_ids, array: true, default: []
      t.integer :direct_report_ids, array: true, default: []
      t.integer :access_level_ids,  array: true, default: []

      t.timestamps null: false
    end
  end
end
