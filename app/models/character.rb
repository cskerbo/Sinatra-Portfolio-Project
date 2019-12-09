require_relative '../models/concerns/slug.rb'

class Character < ActiveRecord::Base
  belongs_to :user
  has_many :perks
  extend Slug::ClassMethods
  include Slug::InstanceMethods
end
