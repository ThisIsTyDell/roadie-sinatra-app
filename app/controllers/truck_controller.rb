class TruckController < ApplicationController
  
  get '/trucks' do
    @user = current_user
    erb :'trucks/show'
  end

end