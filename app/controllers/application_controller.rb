class ApplicationController < ActionController::Base
  include Canable::Enforcers
  protect_from_forgery
  before_filter :current_user
  rescue_from Canable::Transgression, :with => :render_403
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  protected
  def same_user? user
    if @current_user.id!=user.id
      flash[:error] = "This object isn't yours"
      redirect_to :back
    end
  end
  def render_403(e)
    respond_to do |format|
      format.html { 
        flash[:error] = 'Unauthorizated access'
        redirect_to root_url
      }
      format.json { render json: '', :status => 403 }
    end
  end
  def render_404(e)
    respond_to do |format|
      format.html { 
        flash[:error] = 'Object not found'
        redirect_to root_url
      }
      format.json { render json: '', :status => 404 }
    end
  end
  private
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user ||= User.find_guest.first
    end
    User.current=@current_user
  end
  def require_login
    if @current_user.guest
      flash[:error] = "You must be logged in to access this section"
      redirect_to root_url
    end
  end
end
