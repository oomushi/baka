class ChoicesController < ApplicationController
  before_action :set_choice, only: [:destroy]
  # POST /choices
  def create
    @choice = Choice.new(choice_params)

    if @choice.save
      render json: @choice, status: :created, location: @choice
    else
      render json: @choice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /choices/1
  def destroy
    @choice.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_choice
      @choice = Choice.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def choice_params
      params.require(:choice).permit(:text, :poll_id)
    end
end
