class AddIsDraftToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :is_draft, :boolean, default: true, null: false
  end
end
