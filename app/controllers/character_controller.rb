class CharacterController < ApplicationController

 get '/characters' do
   @characters = Character.all
   erb :'characters/index'
 end

 get '/characters/:slug' do
   slug = params[:slug]
   @character = Character.find_by_slug(slug)
   erb :'characters/show'
 end

end
