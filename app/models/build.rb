require_relative '../models/concerns/slug.rb'

class Build < ActiveRecord::Base
  belongs_to :user
  has_many :characters
  has_many :perks, through: :characters
  extend Slug::ClassMethods
  include Slug::InstanceMethods
end

