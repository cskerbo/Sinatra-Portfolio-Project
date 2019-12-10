class BuildController < ApplicationController

  get '/build' do
    @characters = Character.all
    @perks = Perks.all
    erb :'build/new'
  end


end