
require_relative '../models/concerns/slug.rb'
class Perks < ActiveRecord::Base
  belongs_to :character
  extend Slug::ClassMethods
  include Slug::InstanceMethods
end
