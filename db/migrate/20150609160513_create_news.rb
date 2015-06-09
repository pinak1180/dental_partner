class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.date :release_date
      t.date :expiry_date
      t.string :tags, array: true
      t.string :content

      t.timestamps null: false
    end
  end
end
