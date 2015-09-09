class CreateDirectReports < ActiveRecord::Migration
  def change
    create_table :direct_reports do |t|
      t.string :email
      t.string :name

      t.timestamps null: false
    end
  end
end
