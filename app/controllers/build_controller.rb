require 'pry'
require 'sinatra/flash'
class BuildController < ApplicationController

  get '/build' do
    @characters = Character.all
    @perks = Perk.all
    @image_list = Dir.glob("public/images/perks/*.{png}")
    erb :'build/new'
  end

  post '/build' do
    @build = Build.create(params[:build])
    if @build.perk_ids.count > 4
      flash[:error] = "You can only have 4 perks in your loadout, please remove #{@build.perk_ids.count - 4}"
      else
      @build.save
      redirect "/build/#{@build.id}"
    end

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