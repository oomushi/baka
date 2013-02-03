class AnswersController < ApplicationController
  before_filter :require_login

  # PUT /answers/1
  # PUT /answers/1.json
  def vote
    @answer = Answer.find(params[:id])
    enforce_vote_permission(@answer)
    respond_to do |format|
      if @answer.vote(@current_user)
        format.html { redirect_to :back, notice: t(:ok_answers) }
        format.json { head :no_content }
      else
        format.html { redirect_to :back, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer = Answer.find(params[:id])
    enforce_destroy_permission(@answer)
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to answers_url }
      format.json { head :no_content }
    end
  end
end
