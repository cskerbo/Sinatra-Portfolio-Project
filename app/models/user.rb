require_relative '../models/concerns/slug.rb'

class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email, :password
  validates_uniqueness_of :username, :email, :allow_blank => false
  has_many :characters
  extend Slug::ClassMethods
  include Slug::InstanceMethods
end
