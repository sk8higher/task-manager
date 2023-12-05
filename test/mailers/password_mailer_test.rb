require "test_helper"

class PasswordMailerTest < ActionMailer::TestCase
  test "reset" do
    user = create(:user)
    token = user.generate_password_token!
    params = { user: user, token: token }
    email = PasswordMailer.with(params).reset

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['noreply@taskmanager.com'], email.from
    assert_equal [user.email], email.to
    assert_equal "Change your password", email.subject
    assert email.body.to_s.include?("someone requested a reset of your password")
  end
end
