class Avatar < ActiveRecord::Base
  validates_presence_of :user_id
  validates_uniqueness_of :user_id
  belongs_to :user
  validate :right_size?
  
  def destroy
    self.file=nil
    self.url='/assets/guest.png'
    self.content_type=''
    self.save
  end

  def to_s
    self.url=='' ? "/avatars/#{self.id}"  : self.url
  end
   
  def uploaded_data= image
    self.file = image.read
    self.content_type = image.content_type.chomp 
  end
    
  protected
  def right_size?
    unless self.file.nil?
      begin 
        image = MiniMagick::Image.read self.file
        errors.add(:uploaded_data, "width to high") if image['width'] > 128 # parametro da prendere da qualche altra parte
        errors.add(:uploaded_data, "hight to high") if image['height'] > 128 # parametro da prendere da qualche altra parte
        errors.add(:uploaded_data, "invalid image type") unless ['image/png','image/gif','image/jpeg'].include? image.mime_type # parametro da prendere da qualche altra parte
      rescue
        errors.add(:uploaded_data, "invalid image type")
      end
   end
  end
end