require 'pry'

class CharacterController < ApplicationController

 get '/characters' do
   @characters = Character.all
   erb :'characters/index'
 end

 get '/characters/:slug' do
   slug = params[:slug]
   @character = Character.find_by_slug(slug)
   @image_list = Dir.glob("public/images/perks/*.{png}")
   @perks = Perks.all

   erb :'characters/show'
 end


end
