class ApplicationController < ActionController::Base
  include AuthHelper

  before_action :authenticate_user!, except: [:new, :create]
end
