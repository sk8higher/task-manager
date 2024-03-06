module PasswordResetsService
  class << self
    def generate_password_token!(user)
      user.update!({
                     password_reset_token: SecureRandom.hex(20),
                     password_reset_token_expires_at: Time.now.utc + 24.hours,
                   })

      user.password_reset_token
    end

    def password_token_valid?(user)
      user&.password_reset_token_expires_at > Time.now.utc
    end

    def change_password!(user, password)
      user.update!({
                     password_reset_token: nil,
                     password_reset_token_expires_at: nil,
                     password: password,
                   })
    end
  end
end
