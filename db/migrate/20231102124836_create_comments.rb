  class CreateComments < ActiveRecord::Migration[7.1]
    def change
      create_table :comments do |t|
        t.integer :user_id, null: false
        t.integer :post_id, null: false
        t.text :text

        t.timestamps
      end
      add_foreign_key :comments, :users, column: :user_id
      add_foreign_key :comments, :posts, column: :post_id
    end
  end
