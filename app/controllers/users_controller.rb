class UsersController < ApplicationController
  before_filter :require_login, :except => [:new, :create, :complete, :show]
  before_filter :avoid_login, :only => [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.order('username asc').page params[:page]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @user.contacts.build({protocol: 'email'})
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find params[:id]
    enforce_update_permission(@user)
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user]).import(params)
    respond_to do |format|
      if !verify_recaptcha(:model => @user)
        format.html { render action: "new", :alert=> t(:ko_captcha) }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      elsif @user.save 
        format.html { redirect_to root_url, notice: t(:ok_user_new) }
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
    @user = User.find params[:id]
    enforce_update_permission(@user)

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: t(:ok_user_edit) }
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
    enforce_destroy_permission(@user)
    same=@user.eql? @current_user
    @user.destroy

    respond_to do |format|
      format.html {
        if same
          redirect_to logout_url
        else
          redirect_to users_url
        end
      }
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
    render :json => users.to_json(:methods=>:value)
  end
end
