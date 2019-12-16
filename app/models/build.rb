require_relative '../models/concerns/slug.rb'

class Build < ActiveRecord::Base
  belongs_to :user
  has_many :perks, through: :builds
  has_many :characters, through: :builds
  extend Slug::ClassMethods
  include Slug::InstanceMethods
end

