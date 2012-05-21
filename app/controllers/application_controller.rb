class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user
  protected
  def same_user? user
    if @current_user.id!=user.id
      flash[:error] = "This object isn't yours"
      redirect_to :back
    end
  end
  private
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user ||= User.find(2)
    end
  end
  def require_login
    if @current_user.nil?
      flash[:error] = "You must be logged in to access this section"
      redirect_to '/'
    end
  end
end
