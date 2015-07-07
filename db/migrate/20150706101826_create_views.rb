class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.string :viewable_type
      t.integer :viewable_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
