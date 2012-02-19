class AvatarsController < ApplicationController
  # GET /avatars/1
  # GET /avatars/1.json
  def show
    @avatar = Avatar.find(params[:id])
    send_data(@avatar.file,
              :type  => @avatar.content_type,
              :disposition => 'inline')
  end

  # GET /avatars/1/edit
  def edit
    @avatar = Avatar.find(params[:id])
  end

  # PUT /avatars/1
  # PUT /avatars/1.json
  def update
    @avatar = Avatar.find(params[:id])

    respond_to do |format|
      if @avatar.update_attributes(params[:avatar])
        format.html { redirect_to @avatar.user,:action=>'edit', notice: 'Avatar was successfully updated.' }
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
    @avatar.destroy

    respond_to do |format|
      format.html { redirect_to avatars_url }
      format.json { head :ok }
    end
  end
end
