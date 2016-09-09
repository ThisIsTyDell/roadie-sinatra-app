class TruckController < ApplicationController
  
  get '/trucks' do
    if logged_in?
      @user = current_user
      erb :'trucks/trucks'
    else
      redirect to '/login'
    end
  end

  get '/trucks/new' do
    if logged_in?
      erb :'trucks/create_truck'
    else
      redirect '/login'
    end
  end

  post '/trucks' do
    if params[:name] != ""
      new_truck = current_user.trucks.create(params)
      redirect '/trucks'
    else
      redirect '/trucks/new'
    end
  end

end