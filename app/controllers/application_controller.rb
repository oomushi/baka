class ApplicationController < ActionController::API
  before_action :check_token
  attr_reader :current_user
  
  private
  def check_token
    if request.headers['Authorization'].present?
      header = request.headers['Authorization'].split(' ').last
      decoded_token ||= JsonWebToken.decode header 
      @current_user ||= User.find decoded_token if decoded_token
      @current_user ||= User.guest
    else
      render json: {error: 'Missing token'}, status: 401
    end
  end
end
