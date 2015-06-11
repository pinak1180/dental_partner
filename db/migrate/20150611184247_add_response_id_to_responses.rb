class AddResponseIdToResponses < ActiveRecord::Migration
  def change
    add_column :response_details, :response_id, :integer
  end
end
