class User < ActiveRecord::Base
  has_many :characters
  has_many :perks, through: :characters
end
