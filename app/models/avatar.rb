class Avatar < ActiveRecord::Base
  validates_presence_of :user_id
  validates_uniqueness_of :user_id
  belongs_to :user
  validate :right_size?
  
  def to_s
    self.url=='' ? "/avatars/#{self.id}"  : self.url
  end
   
  def uploaded_data= image
    self.file = image.read
    self.content_type = image.content_type.chomp 
  end
    
  protected
  def right_size?
#   unless self.file.nil?
    image = MiniMagick::Image.read self.file
    errors.add(:uploaded_data, "width to high") if image['width'] > 128 # parametro da prendere da qualche altra parte
    errors.add(:uploaded_data, "hight to high") if image['height'] > 128 # parametro da prendere da qualche altra parte
#   end
  end
end
