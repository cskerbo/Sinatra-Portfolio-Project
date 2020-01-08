require_relative '../models/concerns/slug.rb'
class Perk < ActiveRecord::Base
  has_many :build_perks
  has_many :builds, through: :build_perks
  extend Slug::ClassMethods
  include Slug::InstanceMethods
end
