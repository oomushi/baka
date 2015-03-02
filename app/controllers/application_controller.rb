class ApplicationController < ActionController::Base
  include Canable::Enforcers
  protect_from_forgery
  before_filter :current_user
  before_filter :set_locale
  rescue_from Canable::Transgression, :with => :render_403
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  protected
  def render_403(e)
    respond_to do |format|
      format.html { 
        flash[:error] = t(:unauthorizated) 
        redirect_to root_url
      }
      format.json { render json: '', :status => 403 }
    end
  end
  def render_404(e)
    respond_to do |format|
      format.html { 
        flash[:error] = t(:object_not_found)
        redirect_to root_url
      }
      format.json { render json: '', :status => 404 }
    end
  end
  private
  def set_locale
    I18n.locale = extract_locale_from_accept_language_header
  end
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user ||= User.guest.first
    end
    User.current=@current_user
  end
  def avoid_login
    unless @current_user.guest?
      redirect_to root_url
    end
  end
  def require_login
    if @current_user.guest?
      flash[:error] = t(:require_login) 
      redirect_to root_url
    end
  end
end
