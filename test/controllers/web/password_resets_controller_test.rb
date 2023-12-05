require 'test_helper'

class Web::PasswordResetsControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    @token = @user.generate_password_token!
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should post create' do
    post :create, params: { user: { email: @user.email } }
    assert_response :redirect
  end

  test 'should get edit' do
    get :edit, params: { user: @user, token: @token }
    assert_response :success
  end

  test 'should post update' do
    new_pass_user = build(:user)

    post :update, params: { user: { password: new_pass_user.password, password_confirmation: new_pass_user.password }, token: @token }
    assert_response :redirect
  end
end
