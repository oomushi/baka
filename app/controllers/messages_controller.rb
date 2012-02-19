class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def index
    redirect_to :action=>'show',:id=>1
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    message = Message.find(params[:id])
    @path=message.paths
    if message.section
      @messages = message.messages.where('id<>?',params[:id]).order("pinned desc, section desc, created_at desc").page params[:page] # REM questo serve in root per non includere sé stessi
    else
      @messages = message.ancestors.page params[:page]
    end
    respond_to do |format|
      format.html {render( message.section ? :index : :show)}  # index.html.erb | show.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
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
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
end
