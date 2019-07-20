class Attachment < ApplicationRecord
  belongs_to :message
  validates :file, presence: true, length: {maximum: 512000},allow_blank: false

  def uploaded_data= image
    self.file = image.read
    self.content_type = image.content_type.chomp
    self.name = image.original_filename.chomp
  end
end
