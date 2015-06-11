class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string  :title
      t.text    :description
      t.date    :release_date
      t.date    :expiry_date
      t.string  :tags,              array: true
      t.integer :position_ids,      array: true, default: []
      t.integer :department_ids,    array: true, default: []
      t.integer :practise_code_ids, array: true, default: []
      t.integer :direct_report_ids, array: true, default: []
      t.integer :access_level_ids,  array: true, default: []
      t.timestamps                  null: false
    end
  end
end
