class AddIndividualUserIdsToAll < ActiveRecord::Migration
  def change
    add_column :news, :individual_user_ids, :integer, array: true, default: []
    add_column :messages, :individual_user_ids, :integer, array: true, default: []
    add_column :forums, :individual_user_ids, :integer, array: true, default: []
    add_column :surveys, :individual_user_ids, :integer, array: true, default: []

    add_index :news, :individual_user_ids, using: 'gin'
    add_index :messages, :individual_user_ids, using: 'gin'
    add_index :forums, :individual_user_ids, using: 'gin'
    add_index :surveys, :individual_user_ids, using: 'gin'
  end
end
