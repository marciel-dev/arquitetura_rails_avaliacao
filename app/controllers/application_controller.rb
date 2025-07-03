class ApplicationController < ActionController::Base
  include Draper::ViewContext
  helper_method :current_user, :logged_in?, :admin?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def admin?
    current_user&.role == "admin"
  end
end
