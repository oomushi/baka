class Avatar < ActiveRecord::Base
  include Canable::Ables
  validates_presence_of :user_id
  validates_uniqueness_of :user_id
  belongs_to :user
  validate :right_size?
  
  def updatable_by? user
    same_user? user
  end
  def destroyable_by? user
    same_user? user
  end
  
  def destroy
    self.file=nil
    self.url='/assets/guest.png'
    self.content_type=''
    self.save
  end

  def url?
    self.url!=''
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
        errors.add(:uploaded_data, I18n.t(:image_width)) if image['width'] > 128 # parametro da prendere da qualche altra parte
        errors.add(:uploaded_data, I18n.t(:image_height)) if image['height'] > 128 # parametro da prendere da qualche altra parte
        errors.add(:uploaded_data, I18n.t(:image_type)) unless ['image/png','image/gif','image/jpeg'].include? image.mime_type # parametro da prendere da qualche altra parte
      rescue
        errors.add(:uploaded_data, I18n.t(:image_type))
      end
   end
  end
  private
  def same_user? user
    self.user.id==user.id
  end
end
