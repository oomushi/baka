class Avatar < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true, uniqueness: true
  validate :right_size?
  
  def destroy
    self.url='/assets/guest.png'
    self.save
  end
  
  def uploaded_data= image
    self.url = 'data:'+image.content_type.chomp+';base64,'+Base64.strict_encode64(image.read)
  end
  
  protected
  def right_size? 
    if self.url =~ /^data:/
      begin 
        image = MiniMagick::Image.read Base64.decode64(self.url.gsub(/^.+?,/,''))
        errors.add(:uploaded_data, I18n.t(:image_width)) if image['width'] > 128 # parametro da prendere da qualche altra parte
        errors.add(:uploaded_data, I18n.t(:image_height)) if image['height'] > 128 # parametro da prendere da qualche altra parte
        errors.add(:uploaded_data, I18n.t(:image_type)) unless ['image/png','image/gif','image/jpeg'].include? image.mime_type # parametro da prendere da qualche altra parte
      rescue
        errors.add(:uploaded_data, I18n.t(:image_type))
      end
   end
  end
end
