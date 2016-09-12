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
      flash[:message] = "Successfully created a new truck."
      redirect '/trucks'
    else
      redirect '/trucks/new'
    end
  end

  get '/trucks/:id' do
    @truck = Truck.find_by_id(params[:id])
    if logged_in? && current_user.id == @truck.user_id
      erb :'trucks/show_truck'
    else
      redirect '/login'
    end
  end

  get '/trucks/:id/edit' do
    @truck = Truck.find_by_id(params[:id])
    if logged_in? && current_user.id == @truck.user_id
      erb :'trucks/edit_truck'
    else
      redirect '/login'
    end
  end

  patch '/trucks/:id' do
    if params[:name] != ""
      truck = current_user.trucks.find(params[:id])
      truck.update(name: params[:name])
      flash[:message] = "Name change successful."
      redirect "trucks/#{truck.id}"
    else
      redirect "trucks/#{params[:id]}/edit"
    end
  end

  delete '/trucks/:id/delete' do
    truck = Truck.find_by_id(params[:id])
    if logged_in? && current_user.id == truck.user_id
      truck.delete
      flash[:message] = "Truck deleted successfully."
      redirect '/trucks'
    else
      redirect '/login'
    end
  end

  delete '/trucks/delete_all' do
    current_user.trucks.delete_all
    flash[:message] = "All trucks deleted successfully."
    redirect '/profile'
  end
end