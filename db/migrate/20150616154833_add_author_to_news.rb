class AddAuthorToNews < ActiveRecord::Migration
  def change
    add_column :news, :author_name, :string
  end
end
