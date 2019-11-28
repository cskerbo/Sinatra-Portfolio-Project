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
      redirect '/login'
    else
      if user.errors.messages[:username]
        flash[:username_error] = "Username #{user.errors.messages[:username][0]}"
      elsif user.errors.messages[:email]
        flash[:email_error] = "Email #{user.errors.messages[:email][0]}"
      end
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
