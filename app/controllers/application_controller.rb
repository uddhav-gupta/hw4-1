class ApplicationController < ActionController::Base
  before_action :current_user
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user
  
  def require_login
    if !@current_user
      redirect_to login_path, alert: "Please login first"
    end
  end
end