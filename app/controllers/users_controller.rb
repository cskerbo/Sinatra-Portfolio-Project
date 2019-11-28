require 'pry'

class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/users/show'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Account created successfully!"
      binding.pry
      redirect '/login'
    else
      flash[:notice] = "Username #{user.errors.messages[:username][0]}"
      flash[:email_error] = "Test"
      binding.pry
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
       redirect to '/users/show'
   else
     erb :'users/login'
   end
  end

  get "/logout" do
    session.clear
    redirect "/"
  end
end
