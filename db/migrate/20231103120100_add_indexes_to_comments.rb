class AddIndexesToComments < ActiveRecord::Migration[7.1]
  def change
    if table_exists?(:comments)
      add_index :comments, :user_id
      add_index :comments, :post_id
    end
  end
end