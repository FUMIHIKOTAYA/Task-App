class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  helper_method :current_user_admin?

  def current_user_admin?
    current_user.admin == true
  end
end
