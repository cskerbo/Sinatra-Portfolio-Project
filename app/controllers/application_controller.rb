require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    #Using SecureRandom blocks storage of flash messages
    set :session_secret, "secret"
    register Sinatra::Flash
  end

  get '/' do
    @characters = Character.all
    @perks = Perk.all
    @image_list = Dir.glob("public/images/perks/*.{png}")
    erb :index
  end

  helpers do
     def logged_in?
       !!session[:user_id]
     end

     def current_user
       User.find(session[:user_id])
     end
  end
end
