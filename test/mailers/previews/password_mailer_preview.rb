# Preview all emails at http://localhost:3000/rails/mailers/password_mailer
class PasswordMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/password_mailer/reset
  def reset
    user = User.first
    token = user.generate_password_token!

    params = { user: user, token: token }

    PasswordMailer.with(params).reset
  end
end
