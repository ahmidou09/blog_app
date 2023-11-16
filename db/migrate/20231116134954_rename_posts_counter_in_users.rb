class RenamePostsCounterInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :posts_counter, :post_counter
  end
end
