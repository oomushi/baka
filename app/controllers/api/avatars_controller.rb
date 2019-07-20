class Api::AvatarsController < ApplicationController
  before_action :set_avatar

  # GET /avatars/1
  def show
    render json: @avatar
  end

  # PATCH/PUT /avatars/1
  def update
    if @avatar.update(avatar_params)
      render json: @avatar
    else
      render json: @avatar.errors, status: :unprocessable_entity
    end
  end

  # DELETE /avatars/1
  def destroy
    @avatar.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_avatar
      @avatar = Avatar.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def avatar_params
      params.require(:avatar).permit(:user_id, :url, :file)
    end
end
