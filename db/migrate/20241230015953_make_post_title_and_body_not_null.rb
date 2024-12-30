class MakePostTitleAndBodyNotNull < ActiveRecord::Migration[7.2]
  def change
    change_column_null :posts, :title, false
    change_column_null :posts, :body, false
  end
end
