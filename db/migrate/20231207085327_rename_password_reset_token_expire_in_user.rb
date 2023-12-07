class RenamePasswordResetTokenExpireInUser < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :password_reset_token_expire, :password_reset_token_expires_at
  end
end
