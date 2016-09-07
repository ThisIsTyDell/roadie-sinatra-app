class UserController < ApplicationController

  get '/signup' do
    erb :'/user/signup'
  end

  post '/signup' do
    user = User.create(params)
    session[:id] = user.id
    redirect to '/'
  end
end