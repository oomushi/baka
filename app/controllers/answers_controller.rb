class AnswersController < ApplicationController
  # POST /answers
  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      render json: @answer, status: :created, location: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end
end
