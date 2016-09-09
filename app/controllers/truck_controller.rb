class TruckController < ApplicationController
  
  get '/trucks' do
    if logged_in?
      @user = current_user
      erb :'trucks/show'
    else
      redirect to '/login'
    end
  end

end