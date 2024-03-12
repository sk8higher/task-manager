class Web::PasswordResetsController < Web::ApplicationController
  skip_before_action :authenticate_user!

  def new
    @password_reset_form = PasswordResetForm.new
  end

  def create
    @password_reset_form = PasswordResetForm.new(reset_params)
    return render(:new) if @password_reset_form.invalid?

    user = @password_reset_form.user
    PasswordResetsService.generate_password_token!(user)

    Passwords::SendPasswordResetMailJob.perform_async(user.id)

    redirect_to(new_session_path, notice: 'If an account associated with this email was found, we have sent a link to reset password.')
  end

  def edit
    @password_set_form = PasswordSetForm.new(token: params[:token])

    redirect_to(new_session_path, alert: 'Your reset token has expired. Please try again.') unless @password_set_form.password_token_valid?
  end

  def update
    @password_set_form = PasswordSetForm.new(new_password_params)
    user = @password_set_form.user

    redirect_to(new_session_path, alert: 'Your reset token has expired. Please try again.') unless @password_set_form.password_token_valid?

    PasswordResetsService.change_password!(user, @password_set_form.password)
    redirect_to(new_session_path, notice: 'Your password was reset successfully.')
  end

  private

  def reset_params
    params.require(:password_reset_form).permit(:email)
  end

  def new_password_params
    params.require(:password_set_form).permit(:password, :password_confirmation, :token)
  end
end
