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
      flash[:message] = "Successfully Created Account"
      redirect to '/trucks'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/trucks'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/trucks'
    else
      flash[:message] = "Username or password was incorrect, please try again."
      erb :'users/login'
    end
  end

  get '/logout' do
    session.clear
    flash[:message] = "Successfully logged out."
    redirect to '/login'
  end

  get '/profile' do
    erb :'users/profile'
  end

  delete '/profile/delete_account' do
    current_user.destroy
    session.clear
    redirect to '/login'
  end
  
end