require_relative '../models/concerns/slug.rb'

class BuildPerk < ActiveRecord::Base
  belongs_to :build
  belongs_to :perk
  extend Slug::ClassMethods
  include Slug::InstanceMethods
end