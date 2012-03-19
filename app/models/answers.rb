class Answer < ActiveRecord::Base
  belongs_to :poll
  has_many :answers_users,:dependent=>:destroy
  has_many :users,:through => :answers_users,:dependent=>:destroy
end
