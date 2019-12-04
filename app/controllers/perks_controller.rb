require 'pry'

class PerksController < ApplicationController
 get '/perks' do
   @perks = Perks.all
   @image_list = Dir.glob("public/images/perks/*.{png}")
   binding.pry
   erb :'perks/index'
 end
end
