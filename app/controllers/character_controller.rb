class CharacterController < ApplicationController
 get '/characters' do
   @characters = Character.all
   erb :'characters/index'
 end
end
