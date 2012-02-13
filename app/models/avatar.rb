class Avatar < ActiveRecord::Base
  validates_presence_of :user_id
  validates_uniqueness_of :user_id
  belongs_to :user
  def to_s
    self.url.nil? ? "/avatars/#{self.id}"  : self.url
  end
end
