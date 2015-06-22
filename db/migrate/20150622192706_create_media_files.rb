class CreateMediaFiles < ActiveRecord::Migration
  def change
    create_table :media_files do |t|
      t.references :fileable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
