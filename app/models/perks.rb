
require_relative '../models/concerns/slug.rb'
class Perks < ActiveRecord::Base
  belongs_to :build
  extend Slug::ClassMethods
  include Slug::InstanceMethods
end
