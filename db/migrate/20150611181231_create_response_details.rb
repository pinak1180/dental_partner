class CreateResponseDetails < ActiveRecord::Migration
  def change
    create_table :response_details do |t|
      t.integer :question_id
      t.integer :answer_id

      t.timestamps null: false
    end
  end
end
