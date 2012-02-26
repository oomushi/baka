class UsersController < ApplicationController
  before_filter :require_login
  skip_before_filter :require_login, :only => [:show,:index,:complete]
  
  # GET /users
  # GET /users.json
  def index
    @users = User.order("username asc").page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html { render :layout=>'application2'} # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  # only admin can do this
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    same_user? @user
    render :layout=>'application2'
  end

  # POST /users
  # POST /users.json
  # only admin can do this
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    same_user? @user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    same_user? @user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def complete
    string=request.GET[:term]
    if request.GET[:exac].nil?
      users=User.where("username like ?","%#{string}%")
    else
      users=User.where("username = ?",string)
    end
    users.each { |u| u["value"] = u.username }
    render :json => users
  end
end
