require 'pry'
require 'sinatra/flash'
class BuildController < ApplicationController

  get '/build' do
      @characters = Character.all
      @perks = Perk.all
      @image_list = Dir.glob("public/images/perks/*.{png}")
      erb :'build/index'
  end

  post '/build/new' do

      @build = Build.create(params[:build])
      @build.save
      redirect "build/new/#{@build.id}"

  end

  get '/build/new/:id' do
    @build = Build.find(params[:id])
    @characters = Character.all
    @perks = Perk.all
    @image_list = Dir.glob("public/images/perks/*.{png}")
    erb :'build/new'
  end

  patch '/build/:id' do
    @build = Build.find(params[:id])
    @build.update(params[:build])
    @build.save
    redirect to "/build/#{@build.id}"
  end


  get '/build/:id' do
    @perks = []
    @image_list = Dir.glob("public/images/perks/*.{png}")
    @build = Build.find(params[:id])
    @build.perk_ids.each do |p|
      perk = Perk.find(p)
      @perks << perk
      end
    erb :'build/show'
  end



end