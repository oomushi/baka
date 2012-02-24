class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def require_login
    if @current_user.nil?
      flash[:error] = "You must be logged in to access this section"
      redirect_to '/'
    end
  end
end
