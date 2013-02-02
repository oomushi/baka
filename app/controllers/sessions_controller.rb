class SessionsController < ApplicationController
  skip_before_filter :current_user, :only => :destroy
  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to :back, :notice => "Logged in!"
    else
      redirect_to :back, :alert=> "Invalid username or password"
    end
  end
  def destroy
    session[:user_id] = nil
    @current_user = nil
    User.current=nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
