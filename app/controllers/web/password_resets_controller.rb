class Web::PasswordResetsController < Web::ApplicationController
  skip_before_action :authenticate_user!

  def create
    if @user = User.find_by_email(params[:user][:email])
      token = @user.generate_password_token!
      PasswordMailer.with(user: @user, token: token).reset.deliver_now
    end

    redirect_to(new_session_path, notice: 'If an account associated with this email was found, we have sent a link to reset password.')
  end

  def edit
    @user = User.find_by(password_reset_token: params[:token])

    redirect_to(new_session_path, alert: 'Your reset token has expired. Please try again.') unless @user&.password_token_valid?
  end

  def update
    @user = User.find_by(password_reset_token: params[:token])

    if @user.password_token_valid?
      @user.reset_password!(password_params)
      redirect_to(new_session_path, notice: 'Your password was reset successfully.')
    else
      redirect_to(new_session_path, alert: 'Your token has expired. Please try again.')
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :token)
  end
end
