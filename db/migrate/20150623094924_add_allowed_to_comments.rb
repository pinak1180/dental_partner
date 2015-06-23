class AddAllowedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :allowed, :boolean, default: true
  end
end
