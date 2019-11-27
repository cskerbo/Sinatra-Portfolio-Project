class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email, :password
  validates_uniqueness_of :username, :email, :allow_blank => false
  has_many :characters
  has_many :perks, through: :characters
end
