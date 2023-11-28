class PasswordMailer < ApplicationMailer
  def reset
    @user = params[:user]
    @token = @user.signed_id(purpose: 'password_reset', expires_in: 24.hours)

    mail(to: @user.email, subject: 'Change your password')
  end
end
