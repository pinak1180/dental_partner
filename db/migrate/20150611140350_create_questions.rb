class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :survey_id
      t.string :question
      t.boolean :compulsory

      t.timestamps null: false
    end
  end
end
