class CreateAccessLevals < ActiveRecord::Migration
  def change
    create_table :access_levals do |t|
      t.integer :leval

      t.timestamps null: false
    end
  end
end
