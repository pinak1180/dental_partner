class AddAttachmentToUserNews < ActiveRecord::Migration
  def change
    add_attachment :users, :avatar
    add_attachment :news, :poster_avatar
  end
end
