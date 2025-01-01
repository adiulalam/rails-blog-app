class RemoveBodyFromPosts < ActiveRecord::Migration[7.2]
  def change
    remove_column :posts, :body, :text
  end
end
