class Contact < ApplicationRecord
  attr_accessible :value, :protocol, :user_id
  belongs_to :user
  validates :protocol,:value, presence: true
  validates :value, format: { with: URI::regexp(%w(http https))}, allow_black: false, allow_nil: false, if: website?
  validates :value, format: { with: /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/}, allow_black: false, allow_nil: false, if: email?
  
  ENUM=%w(website email)  
  
  private
  def website?
    protocol.eql? 'website'
  end
  def email?
    protocol.eql? 'email'
  end
end
