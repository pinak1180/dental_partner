class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.references :receivable, polymorphic: true, index: true
      t.string :recipient_ids, array: true
      t.timestamps null: false
    end
  end
end
