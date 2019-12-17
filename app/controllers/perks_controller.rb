require 'pry'

class PerksController < ApplicationController
 get '/perks' do
   @perks = Perk.all
   @image_list = Dir.glob("public/images/perks/*.{png}")

   erb :'perks/index'
 end
end
