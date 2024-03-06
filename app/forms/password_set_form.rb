class PasswordSetForm
  include ActiveModel::Model

  attr_accessor(
    :password,
    :password_confirmation,
    :token,
  )

  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
  validates :token, presence: true

  def user
    @user ||= User.find_by_password_reset_token(token)
  end

  def password_token_valid?
    user && user.password_reset_token_expires_at > Time.now.utc
  end
end
