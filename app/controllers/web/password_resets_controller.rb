class Web::PasswordResetsController < Web::ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create
    if @user = User.find_by_email(params[:user][:email])
      token = PasswordResetsService.generate_password_token!(@user)
      PasswordMailer.with(user: @user, token: token).reset.deliver_now
    end

    redirect_to(new_session_path, notice: 'If an account associated with this email was found, we have sent a link to reset password.')
  end

  def edit
    @user = User.find_by(password_reset_token: params[:token])

    redirect_to(new_session_path, alert: 'Your reset token has expired. Please try again.') unless PasswordResetsService.password_token_valid?(@user)
  end

  def update
    @user = User.find_by(password_reset_token: params[:token])

    return redirect_to(new_session_path, alert: 'Your token has expired. Please try again.') unless @user && PasswordResetsService.password_token_valid?(@user)

    PasswordResetsService.change_password!(@user, password_params)
    redirect_to(new_session_path, notice: 'Your password was reset successfully.')
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :token)
  end
end
