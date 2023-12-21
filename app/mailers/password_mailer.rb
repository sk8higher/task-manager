class PasswordMailer < ApplicationMailer
  def reset
    @user = params[:user]
    @token = PasswordResetsService.generate_password_token!(@user)

    mail(to: @user.email, subject: 'Change your password')
  end
end
