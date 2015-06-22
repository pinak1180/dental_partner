class AddCanPostFeedsToUser < ActiveRecord::Migration
  def change
    add_column :users, :can_post_feed, :boolean, default: false
  end
end
