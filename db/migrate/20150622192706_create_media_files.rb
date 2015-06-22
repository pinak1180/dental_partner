class CreateMediaFiles < ActiveRecord::Migration
  def change
    create_table :media_files do |t|
      t.integer :fileable_id
      t.string :fileable_type

      t.timestamps null: false
    end
  end
end
