class ApplicationController < ActionController::Base
  include AuthHelper

  helper_method :current_user

  before_action :authenticate_user!
end
