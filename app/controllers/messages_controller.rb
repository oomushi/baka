class MessagesController < ApplicationController
  before_filter :require_login
  skip_before_filter :require_login, :only => [:show,:index,:search]

  # GET /messages
  # GET /messages.json
  def index
    root=Message.find 1
    redirect_to root,:flash=>flash.to_hash
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @q = Message.search()
    @root = Message.find(params[:id])
    enforce_view_permission(@root)
    @path=@root.paths(@current_user)
    if @root.section
      @messages = @root.childs(@current_user).order("pinned desc, section desc, created_at desc").page params[:page]
    else
      @messages = @root.ancestors(@current_user).page params[:page]
    end
    respond_to do |format|
      format.html {render( @root.section ? :index : :show)}  # index.html.erb | show.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @root=Message.find params[:id]
    enforce_create_permission(@root)
    @message = @root.replay
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
    enforce_update_permission(@message)
    same_user? @message.user
    unless @message.deletable?
      @message.errors.add :base, "message cannot be edited"
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])
    same_user? @message.user

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    enforce_destroy_permission(@message)
    same_user? @message.user
    id=@message.message_id
    @message.destroy
    respond_to do |format|
      format.html { redirect_to :action=>'show',:id=>id }
      format.json { head :no_content }
    end
  end
  
  # POST /message/search
  # POST /message/search.json
  def search
    @q = Message.search(params[:q])
    @messages = @q.result(:distinct => true)
#    enforce_view_permission(@messages)
    respond_to do |format|
      format.html # search.html.erb
      format.json { render json: @messages }
    end
  end
end
