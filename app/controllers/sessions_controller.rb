class SessionsController < ApplicationController
  skip_before_filter :current_user, :only => :destroy
  def create
    user = User.authenticate env["omniauth.auth"]
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => t(:ok_login)
    else
      redirect_to root_url, :alert=> t(:ko_login)
    end
  end
  def destroy
    session[:user_id] = nil
    @current_user = nil
    User.current=nil
    redirect_to root_url, :notice => t(:ok_logout)
  end
end
