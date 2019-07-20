class Api::TokensController < ApplicationController
  skip_before_action :check_token
  # POST /tokens
  def create
    username = params[:usernam]
    password = params[:password]
    token = JsonWebToken.encode(user_id: user(username,password).id)
    if token
      render json: {auth_token: token}
    else
      render json: {error: 'invalid credentials'}, status: :unauthorized
    end
  end
  
  private
  def user(username,password)
    user = User.find_by_username username
    return user if user && user.authenticate(password)
  end
end
