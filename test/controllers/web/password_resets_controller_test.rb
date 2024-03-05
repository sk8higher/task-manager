require 'test_helper'

class Web::PasswordResetsControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    @token = PasswordResetsService.generate_password_token!(@user)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should post create' do
    attrs = { email: @user.email }

    assert_emails 1 do
      post :create, params: { password_reset_form: attrs }
    end
    assert_response :redirect
  end

  test 'should get edit' do
    get :edit, params: { user: @user, token: @token }
    assert_response :success
  end

  test 'should post update' do
    new_pass = generate(:string)

    attrs = { email: @user.email }

    post :create, params: { password_reset_form: attrs }

    @token = @user.reload.password_reset_token
    new_attrs = {
      password: new_pass,
      password_confirmation: new_pass,
    }

    post :update, params: { password_set_form: new_attrs, token: @token }

    assert_response :redirect
    assert_not_equal @user.password_digest, @user.reload.password_digest
  end
end
