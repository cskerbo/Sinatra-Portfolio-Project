require 'pry'
class BuildController < ApplicationController

  get '/build' do
    @characters = Character.all
    @perks = Perk.all
    @image_list = Dir.glob("public/images/perks/*.{png}")
    erb :'build/new'
  end

  post '/build' do
    @build = Build.create(params[:build])
    @build.save

    redirect "/build/#{@build.id}"
  end

  get '/build/:id' do
    @build = Build.find(params[:id])

    erb :'build/show'
  end

end