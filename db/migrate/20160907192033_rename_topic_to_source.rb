class RenameTopicToSource < ActiveRecord::Migration[5.0]
  def change
    rename_column :upvotes, :topic_id, :source_id
  end
end
