class AttachmentsController < ApplicationController
  before_filter :require_login
  # GET /attachments/1
  # GET /attachments/1.json
  def show
    @attachment = Attachment.find(params[:id])
    send_data(@attachment.file,
              filename: @attachment.name,
              type: @attachment.content_type,
              disposition: 'inline')
  end
end
