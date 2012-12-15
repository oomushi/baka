class LikesController < ApplicationController
  before_filter :require_login
  
  # POST /likes
  # POST /likes.json
  def create
    @like = Like.new(params[:like])
    if @like.save
      redirect_to @like.message, notice: 'Like was successfully created.'
    else
      redirect_to @like.message
    end
  end

  # PUT /likes/1
  # PUT /likes/1.json
  def update
    @like = Like.find(params[:id])
    enforce_update_permission(@like)

    if @like.update_attributes(params[:like])
      redirect_to @like.message, notice: 'Like was successfully updated.'
    else
      redirect_to @like.message
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @like = Like.find(params[:id])
    enforce_destroy_permission(@like)
    
    message=@like.message
    @like.destroy
    redirect_to @like.message
  end
end
