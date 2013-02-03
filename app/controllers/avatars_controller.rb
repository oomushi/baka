class AvatarsController < ApplicationController
  before_filter :require_login
  skip_before_filter :require_login, :only => :show
  
  # GET /avatars/1
  # GET /avatars/1.json
  def show
    @avatar = Avatar.find(params[:id])
    send_data(@avatar.file,
              :type  => @avatar.content_type,
              :disposition => 'inline')
  end

  # PUT /avatars/1
  # PUT /avatars/1.json
  def update
    @avatar = Avatar.find(params[:id])
    enforce_update_permission(@avatar)

    respond_to do |format|
      if @avatar.update_attributes(params[:avatar])
        format.html { redirect_to @avatar.user,:action=>'edit', notice: t(:ok_avatar) }
        format.json { head :ok }
      else
        format.html { redirect_to @avatar.user,:action=>'edit' }
        format.json { render json: @avatar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /avatars/1
  # DELETE /avatars/1.json
  def destroy
    @avatar = Avatar.find(params[:id])
    enforce_destroy_permission(@avatar)
    @avatar.destroy

    respond_to do |format|
      format.html { redirect_to avatars_url }
      format.json { head :ok }
    end
  end
end
