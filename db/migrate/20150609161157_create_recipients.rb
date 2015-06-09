class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.integer :recivable_ids, array: true
      t.string :recivable_type
      t.timestamps null: false
    end
  end
end
