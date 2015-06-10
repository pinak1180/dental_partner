class CreateAdminsForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string  :title
      t.text    :subject
      t.date    :expiry_date
      t.date    :release_date
      t.string  :tags, array: true
      t.integer :position_ids, array: true
      t.integer :department_ids, array: true
      t.integer :practise_code_ids, array: true
      t.integer :direct_report_ids, array: true
      t.integer :access_level_ids, array: true

      t.timestamps null: false
    end
  end
end
