class Attachment < ActiveRecord::Base
  include Canable::Ables
  belongs_to :message
  validates_presence_of :file
  validates_length_of :file, maximum: 512000, allow_blank: false
  
  def uploaded_data= image
    self.file = image.read
    self.content_type = image.content_type.chomp
    self.name = image.original_filename.chomp
  end
end
