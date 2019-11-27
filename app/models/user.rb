class User < ActiveRecord::Base
  has_secure_password
  has_many :characters
  has_many :perks, through: :characters
end
