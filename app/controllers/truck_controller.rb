class TruckController < ApplicationController
  
  get '/trucks' do
    if logged_in?
      @user = current_user
      erb :'trucks/show'
    else
      redirect to '/login'
    end
  end

  get 'trucks/new' do
    if logged_in?
      erb :'trucks/create_truck.erb'
    else
      redirect '/login'
    end
  end

end