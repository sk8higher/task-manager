class Passwords::SendPasswordResetMailJob < Passwords::ApplicationJob
  def perform(user_id)
    user = User.find_by(id: user_id)
    return if user.blank?

    PasswordMailer.with(user: user, token: user.password_reset_token).reset.deliver_now
  end
end
