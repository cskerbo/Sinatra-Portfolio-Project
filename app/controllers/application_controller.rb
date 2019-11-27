require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end

  get '/' do
    erb :index
  end

  helpers do
     def logged_in?
       !!session[:user_id]
     end

     def current_user
       User.find(session[:user_id])
     end

     def validate_signup
       params[:username] != "" && params[:email] != "" && params[:password] != ""
     end

     def validate_username
       User.find_by(:username => params[:username])
     end

     def validate_email
       User.find_by(:email => params[:email])
     end
   end
end
