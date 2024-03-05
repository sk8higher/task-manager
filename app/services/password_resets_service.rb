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

    def change_password!(user, password)
      user.update!({
                     password_reset_token: nil,
                     password_reset_token_expires_at: nil,
                     password: password,
                   })
    end

    private

    def generate_token
      SecureRandom.hex(20)
    end
  end
end
