class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.timestamps null: false
    end
    add_index :documents, :title, unique: true
  end
end
