class AddIndexesToLikes < ActiveRecord::Migration[7.1]
  def change
    if table_exists?(:likes)
      add_index :likes, :user_id
      add_index :likes, :post_id
    end
  end
end