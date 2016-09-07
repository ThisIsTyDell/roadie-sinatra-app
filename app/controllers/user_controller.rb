class UserController < ApplicationController

  get '/signup' do
    erb :'/user/signup'
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
    erb :'user/login'
  end
end