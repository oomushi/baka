class SessionsController < ApplicationController
  skip_before_filter :current_user, :only => :destroy
  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to :back, :notice => t(:login)
    else
      redirect_to :back, :alert=> t(:ko_login)
    end
  end
  def destroy
    session[:user_id] = nil
    @current_user = nil
    User.current=nil
    redirect_to root_url, :notice => t(:logout)
  end
end
