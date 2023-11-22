class AddIndexToUsersConfirmationToken < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :confirmation_token, unique: true
  end
end
