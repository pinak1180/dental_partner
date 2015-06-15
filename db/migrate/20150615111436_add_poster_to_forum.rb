class AddPosterToForum < ActiveRecord::Migration
  def change
    add_attachment :forums, :poster_avatar
  end
end
