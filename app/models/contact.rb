class Contact < ApplicationRecord
  belongs_to :user
  validates :protocol,:value, presence: true
  validates :value, format: { with: URI::regexp(%w(http https))}, allow_black: false, allow_nil: false, if: Proc.new{|c| c.protocol.eql? 'website'}
  validates :value, format: { with: /\A([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)\z/}, allow_black: false, allow_nil: false, if: Proc.new{|c| c.protocol.eql? 'email'} 
  
  ENUM=%w(website email)
end
