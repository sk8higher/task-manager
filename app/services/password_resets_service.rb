module PasswordResetsService
  class << self
    def generate_password_token!(user)
      user.update!({
                     password_reset_token: generate_token,
                     password_reset_token_expires_at: Time.now.utc,
                   })

      user.password_reset_token
    end

    def password_token_valid?(user)
      (user&.password_reset_token_expires_at + 24.hours) > Time.now.utc
    end

    def change_password!(user, password_params)
      user.update!({
                     password_reset_token: nil,
                     password: password_params[:password],
                     password_confirmation: password_params[:password_confirmation],
                   })
    end

    private

    def generate_token
      SecureRandom.hex(20)
    end
  end
end
