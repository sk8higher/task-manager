class PasswordMailerPreview < ActionMailer::Preview
  def reset
    user = User.first
    token = user.generate_password_token!

    params = { user: user, token: token }

    PasswordMailer.with(params).reset
  end
end
