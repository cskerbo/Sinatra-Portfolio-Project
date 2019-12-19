require 'pry'
require 'sinatra/flash'
class BuildController < ApplicationController

  get '/build' do
    if logged_in?
      @characters = Character.all
      @perks = Perk.all
      @image_list = Dir.glob("public/images/perks/*.{png}")
      erb :'build/index'
    else
      redirect to '/login'
      end
  end

  post '/build/new' do
    if logged_in?
      @build = current_user.builds.build(params[:build])
      @build.save
      binding.pry
      redirect "build/new/#{@build.id}"
    else
      redirect to '/login'
    end
  end

  get '/build/new/:id' do
    if logged_in?
      @build = Build.find(params[:id])
      @characters = Character.all
      @perks = Perk.all
      @image_list = Dir.glob("public/images/perks/*.{png}")
      erb :'build/new'
    else
      redirect to '/login'
    end
  end

  patch '/build/:id' do
    if logged_in?
      @build = Build.find(params[:id])
      @build.update(params[:build])
      @build.save
      redirect to "/build/#{@build.id}"
    else
      redirect to '/login'
    end
  end


  get '/build/:id' do
    if logged_in?
      @perks = []
      @image_list = Dir.glob("public/images/perks/*.{png}")
      @build = Build.find(params[:id])
      @build.perk_ids.each do |p|
      perk = Perk.find(p)
      @perks << perk
      end
      erb :'build/show'
    else
      redirect to '/login'
    end
  end

end