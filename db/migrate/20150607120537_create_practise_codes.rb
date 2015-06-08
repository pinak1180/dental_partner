class CreatePractiseCodes < ActiveRecord::Migration
  def change
    create_table :practise_codes do |t|
      t.string :code

      t.timestamps null: false
    end
  end
end
