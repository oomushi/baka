class Api::MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]
  skip_before_action :check_token, only: [:show, :index, :search]
  # GET /messages
  def index
    root=Message.first
    redirect_to api_message_path root
  end

  # GET /messages/1
  def show
    #@q = Message.search()
    @root = Message.find(params[:id])
    #@path=@root.paths(@current_user)
    @messages = @root.section ? @root.childs(@current_user).order("pinned desc, section desc, created_at desc").page(params[:page]) : @root.ancestors(@current_user).page(params[:page])
    render json: @messages
  end

  # POST /messages
  def create
    @message = Message.new(message_params)

    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end
  
  # GET /message/search.json
  def search
    @q = Message.search(params[:q])
    @messages=[]
    @q.result(distinct: true).each do |m|
      next if @messages.any?{ |d| d.ancestors(@current_user).include? m }
      ancestors=m.ancestors(@current_user)
      ancestors.each do |del|
        i = @messages.find_index(del)
        @messages.delete_at(i) if i
      end
      @messages << m
    end
#    enforce_view_permission(@messages)
    render json: @messages
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:title, :text, :section, :pinned, :message_id, :user_id, :nv, :dv, :snv, :sdv, :follow, :writer_id, :reader_id, :moderator_id)
    end
end
