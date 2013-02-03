class BbcodesController < ApplicationController
  # GET /bbcodes
  # GET /bbcodes.json
  def index
    @bbcodes = Bbcode.all
    enforce_index_permission(Bbcode)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bbcodes }
    end
  end

  # GET /bbcodes/new
  # GET /bbcodes/new.json
  def new
    @bbcode = Bbcode.new
    enforce_create_permission(@bbcode)
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bbcode }
    end
  end

  # GET /bbcodes/1/edit
  def edit
    @bbcode = Bbcode.find(params[:id])
    enforce_update_permission(@bbcode)
  end

  # POST /bbcodes
  # POST /bbcodes.json
  def create
    @bbcode = Bbcode.new(params[:bbcode])
    enforce_create_permission(@bbcode)
    
    respond_to do |format|
      if @bbcode.save
        format.html { redirect_to @bbcode, notice: t(:ok_bbcode) }
        format.json { render json: @bbcode, status: :created, location: @bbcode }
      else
        format.html { render action: "new" }
        format.json { render json: @bbcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bbcodes/1
  # PUT /bbcodes/1.json
  def update
    @bbcode = Bbcode.find(params[:id])
    enforce_update_permission(@bbcode)
    
    respond_to do |format|
      if @bbcode.update_attributes(params[:bbcode])
        format.html { redirect_to bbcodes_url }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bbcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bbcodes/1
  # DELETE /bbcodes/1.json
  def destroy
    @bbcode = Bbcode.find(params[:id])
    enforce_destroy_permission(@bbcode)
    @bbcode.destroy

    respond_to do |format|
      format.html { redirect_to bbcodes_url }
      format.json { head :no_content }
    end
  end
end
