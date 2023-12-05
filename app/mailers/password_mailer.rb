class PasswordMailer < ApplicationMailer
  def reset
    @user = params[:user]
    @token = @user.generate_password_token!

    mail(to: @user.email, subject: 'Change your password')
  end
end
