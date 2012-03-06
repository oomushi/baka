class User < ActiveRecord::Base
  has_many :messages
  has_many :likes
  has_one :avatar
  has_and_belongs_to_many :poll_options
  attr_protected :password_hash, :password_salt, :confirm_code
  attr_accessor :password
  before_save :encrypt_password
  after_create :confirm_email
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username,:email
  validates_uniqueness_of :username
  validates_format_of :website, :with => URI::regexp(%w(http https)), :allow_black=>true, :allow_nil=>true
  
  def total_likes
    value=0
    self.likes.each do |l|
      value+=l.value
    end
    value
  end

  def self.authenticate(username, password)
    user = find_by_username(username)
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
    # creazione codice
    UserMailer.email_confirmation(self).deliver
  end
end
