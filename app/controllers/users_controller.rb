class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/users/show'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if validate_username && validate_email == nil
      if validate_signup
        user = User.new(params)
          if user.save
            session[:user_id] = user.id
            redirect '/login'
          end
      end
    elsif validate_username != nil
        if validate_email != nil
          flash[:notice] = "Username already exists."
          flash[:error] = "Email already exists."
        else
          flash[:error] = "Username already exists."
        end
    end
      redirect '/signup'
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
