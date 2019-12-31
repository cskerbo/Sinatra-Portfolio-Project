require 'pry'

class CharacterController < ApplicationController

 get '/characters' do
   @characters = Character.all
   @perks = Perk.all
   @image_list = Dir.glob("public/images/perks/*.{png}")
   erb :'characters/index'
 end

 get '/characters/:slug' do
   slug = params[:slug]
   @character = Character.find_by_slug(slug)
   @image_list = Dir.glob("public/images/perks/*.{png}")
   @perks = Perk.all

   erb :'characters/show'
 end


end
