class UserController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect to '/'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/dashboard'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/dashboard'
    else
      erb :'users/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/dashboard' do
    @user = current_user

    erb :'/users/show'
  end
  
end