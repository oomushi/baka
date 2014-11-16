class AvatarsController < ApplicationController
  before_filter :require_login, :except => :show
  
  # GET /avatars/1
  # GET /avatars/1.json
  def show
    @avatar = Avatar.find(params[:id])
    file=''
    content=''
    if @avatar.url?
      url = @avatar.url=~ /^.+:\/\// ? @avatar.url : "#{request.protocol}#{request.host_with_port}#{@avatar.url}"
      get = HTTParty.get(url)
      file = get.body
      content=get.content_type
    else
      file=@avatar.file
      content=@avatar.content_type
    end
    send_data(file,
              :type  => content,
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
