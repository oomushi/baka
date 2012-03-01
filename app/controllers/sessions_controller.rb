class SessionsController < ApplicationController
  before_filter :require_login, :only => :destroy
  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to :back, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid username or password"
      redirect_to :back
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
