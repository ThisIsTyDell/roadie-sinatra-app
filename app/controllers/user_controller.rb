class UserController < ApplicationController

  get '/signup' do
    erb :'/user/signup'
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password_digest: params[:password])
  end
end