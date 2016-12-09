class AddUserIdToUpvote < ActiveRecord::Migration[5.0]
  def change
    add_column :upvotes, :user_id, :integer
  end
end
