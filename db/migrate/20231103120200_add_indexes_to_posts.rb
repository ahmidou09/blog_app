class AddIndexesToPosts < ActiveRecord::Migration[7.1]
  def change
    if table_exists?(:posts)
      add_index :posts, :author_id
    end
  end
end