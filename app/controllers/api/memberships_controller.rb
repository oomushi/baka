class Api::MembershipsController < ApplicationController
  before_action :set_membership, only: [:destroy]

  # POST /memberships
  def create
    @membership = Membership.new(membership_params)

    if @membership.save
      render json: @membership, status: :created, location: @membership
    else
      render json: @membership.errors, status: :unprocessable_entity
    end
  end

  # DELETE /memberships/1
  def destroy
    @membership.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def membership_params
      params.require(:membership).permit(:group_id, :user_id)
    end
end
