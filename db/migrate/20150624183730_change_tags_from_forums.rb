class ChangeTagsFromForums < ActiveRecord::Migration
  def up
    change_column :forums, :tags, :text, :default => []
    change_column :news, :tags, :text, :default => []
    change_column :surveys, :tags, :text, :default => []
  end

  def down
    change_column :forums, :tags, :text, :default => nil
    change_column :news, :tags, :text, :default => nil
    change_column :surveys, :tags, :text, :default => nil
  end
end
