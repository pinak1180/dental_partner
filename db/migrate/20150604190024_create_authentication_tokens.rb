class CreateAuthenticationTokens < ActiveRecord::Migration
  def change
    create_table :authentication_tokens do |t|
      t.integer :user_id
      t.string :auth_token

      t.timestamps null: false
    end
  end
end
