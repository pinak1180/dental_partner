class CreateAccessLevals < ActiveRecord::Migration
  def change
    create_table :access_levels do |t|
      t.integer :level

      t.timestamps null: false
    end
  end
end
