class SendPasswordResetMailJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_throttle_as :mailer

  def perform(user_id)
    user = User.find_by(id: user_id)
    return if user.blank?

    PasswordMailer.with(user: user, token: user.password_reset_token).reset.deliver_now
  end
end