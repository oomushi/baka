class Answer < ActiveRecord::Base
  belongs_to :poll
  has_and_belongs_to_many :users
  def vote user
    self.users<<user
    save
  end
end
