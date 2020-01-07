class UsersController < ApplicationController
    get '/signup' do
      if logged_in?
        redirect to '/user_builds'
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
        end
        if user.errors.messages[:email]
          flash[:email_error] = "Email #{user.errors.messages[:email][0]}"
        end
        if user.errors.messages[:password]
          flash[:password_error] = "Password #{user.errors.messages[:password][0]}"
        end
        redirect '/signup'
      end
    end

    get '/login' do
      if logged_in?
         redirect to '/user_builds'
      else
       erb :'users/login'
      end
    end

    post '/login' do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/user_builds"
      else
        redirect '/login'
      end
    end

    #Upcoming "My Profile" feature, currently not active
=begin
    get '/users/show' do
      if logged_in?
        @user = current_user
        @builds = Build.select{|key| key.user_id == @user.id }
        erb :'users/show'
      else
        redirect to '/login'
      end
    end
=end

    get "/logout" do
      session.destroy
      redirect "/login"
    end
end
