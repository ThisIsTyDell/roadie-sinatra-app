class TruckController < ApplicationController
  
  get '/trucks' do
    erb :'trucks/show'
  end

end