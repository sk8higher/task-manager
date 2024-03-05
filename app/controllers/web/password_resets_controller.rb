class Web::PasswordResetsController < Web::ApplicationController
  skip_before_action :authenticate_user!

  def new
    @reset = PasswordResetForm.new
  end

  def create
    @reset = PasswordResetForm.new(reset_params)
    return render(:new) if @reset.invalid?

    user = @reset.user
    token = PasswordResetsService.generate_password_token!(user)

    PasswordMailer.with(user: user, token: token).reset.deliver_now
    redirect_to(new_session_path, notice: 'If an account associated with this email was found, we have sent a link to reset password.')
  end

  def edit
    @new_password = PasswordSetForm.new

    redirect_to(new_session_path, alert: 'Your reset token has expired. Please try again.') unless PasswordResetsService.password_token_valid?(user)
  end

  def update
    @new_password = PasswordSetForm.new(new_password_params)

    return redirect_to(new_session_path, alert: 'Your token has expired. Please try again.') unless user && PasswordResetsService.password_token_valid?(user)

    PasswordResetsService.change_password!(user, @new_password.password)
    redirect_to(new_session_path, notice: 'Your password was reset successfully.')
  end

  private

  def reset_params
    params.require(:password_reset_form).permit(:email)
  end

  def new_password_params
    params.require(:password_set_form).permit(:password, :password_confirmation)
  end

  def user
    @user ||= User.find_by_password_reset_token(params[:token])
  end
end
