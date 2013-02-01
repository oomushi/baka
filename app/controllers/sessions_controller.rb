class SessionsController < ApplicationController
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
    redirect_to root_url, @current_user.guest? ? '' : :notice => "Logged out!"
  end
end
