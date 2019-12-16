require 'pry'
class BuildController < ApplicationController

  get '/build' do
    @characters = Character.all
    @perks = Perks.all
    erb :'build/new'
  end

  post '/build' do
    @build = Build.create(params[:build])
    @build.save

    redirect "/build/#{@build.id}"
  end

  get '/build/:id' do
    @build = Build.find(params[:id])
    character_id = @build.character_id
    @character = Character.find(19)
    erb :'build/show'
  end

end