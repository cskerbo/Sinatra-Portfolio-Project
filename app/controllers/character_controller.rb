class CharacterController < ApplicationController

  get '/characters' do
    @characters = Character.all
    erb :'characters/index'
  end

  get '/characters/:slug' do
    erb :'characters/show'
  end

end
