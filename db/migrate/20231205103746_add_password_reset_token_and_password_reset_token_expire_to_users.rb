class AddPasswordResetTokenAndPasswordResetTokenExpireToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password_reset_token, :string
    add_column :users, :password_reset_token_expire, :datetime
  end
end
