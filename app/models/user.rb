class User < ApplicationRecord
  has_secure_password

  # Validations
  validates :username, presence: true, uniqueness: true
  # Associations
  has_many :messages,dependent: :destroy
  has_many :likes,dependent: :destroy
  has_one :avatar,dependent: :delete
  has_many :contacts,dependent: :destroy
  has_many :answers
  has_many :memberships
  has_many :choises, through: :answers
  has_many :groups, through: :memberships
  # Callbacks
  after_create {|u| u.create_avatar}
  after_create {|u| u.groups << Group.find(3)}
  
  def admin?
    groups.any?{ |g| g.admin? }
  end
  def email
    email=contacts.where('protocol = ?','email').first
    email.nil? ? '' : email.value
  end
  def posts
    messages.where("section = ?", false)
  end
  def as_json(options={})
      super(except: [:password_digest])
    end
  def self.guest
    Group.find(4).users.first
  end
end
