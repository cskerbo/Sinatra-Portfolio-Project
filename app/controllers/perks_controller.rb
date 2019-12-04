class PerksController < ApplicationController
 get '/perks' do
   @perks = Perks.all
   erb :'perks/index'
 end
end
