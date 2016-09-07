class UserController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      user = User.create(params)
      session[:id] = user.id
      redirect to '/'
    end
  end

  get '/login' do
    erb :'users/login'
  end
end