class UserController < ApplicationController

  get '/signup' do
    erb :'/user/signup'
  end

  post '/signup' do
    "#{params}"
  end
end