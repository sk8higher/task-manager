class PasswordResetsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    if @user = User.find_by_email(params[:user][:email])
      PasswordMailer.with(user: @user).reset.deliver_now
    end

    redirect_to new_session_path, notice: 'If an account associated with this email was found, we have sent a link to reset password.'
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: 'password_reset')

  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to new_session_path, alert: 'Your reset token has expired. Please try again.'
  end

  def update
    @user = User.find_signed!(params[:token], purpose: 'password_reset')

    if @user.update(password_params)
      redirect_to new_session_path, notice: 'Your password was reset successfully.'
    else
      render 'edit'
    end

  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to new_session_path, alert: 'Your token has expired. Please try again.'
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :token)
  end
end
