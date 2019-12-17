require_relative '../models/concerns/slug.rb'

class Build < ActiveRecord::Base
  belongs_to :user
  has_many :build_perks
  has_many :perks, through: :build_perks
  has_many :characters, through: :build_perks
  extend Slug::ClassMethods
  include Slug::InstanceMethods
end

