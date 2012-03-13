class User < ActiveRecord::Base
  has_many :messages,:dependent=>:destroy
  has_many :likes,:dependent=>:destroy
  has_one :avatar,:dependent=>:delete
  has_and_belongs_to_many :poll_options
  attr_protected :password_hash, :password_salt, :confirm_code
  attr_accessor :password
  before_save :encrypt_password
  after_create :confirm_email,:create_avatar
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username,:email
  validates_uniqueness_of :username
  validates_format_of :website, :with => URI::regexp(%w(http https)), :allow_black=>true, :allow_nil=>true
  
  def value
    username
  end 
  def total_likes
    value=0
    self.likes.each do |l|
      value+=l.value
    end
    value
  end

  def self.authenticate(username, password)
    user = User.where("username = ? and confirm_code is null",username).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  protected
  def confirm_email
    salt=BCrypt::Engine.generate_salt
    self.confirm_code=BCrypt::Engine.hash_secret("#{self.id} #{self.username} #{self.email} #{self.password_hash} #{self.password_salt} #{self.created_at.to_s} #{rand(29**29)}", salt)
    self.save
    UserMailer.email_confirmation(self).deliver
  end
  def create_avatar
    Avatar.create({:user_id=>self.id})
  end
end
