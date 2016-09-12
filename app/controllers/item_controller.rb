class ItemController < ApplicationController
  
  get '/equipment' do
    if logged_in?
      @user = current_user
      erb :'items/items'
    else
      redirect to '/login'
    end
  end

  get '/equipment/new' do
    if logged_in?
      erb :'items/create_item'
    else
      redirect '/login'
    end
  end

  post '/equipment' do
    filled_in = params[:name] != "" || params[:value] != ""
    case
    when !filled_in || (filled_in && params[:truck] == "" && params[:new_truck] == "")
      flash[:message] = "Please try again by filling out the details"
      redirect '/equipment/new'
      #raise error message to user letting them know they need to fill out the form
    when filled_in && params[:truck] != "" && params[:new_truck] != ""
      flash[:message] = "Sorry, you can not choose existing truck and create new truck at the same time"
      redirect '/equipment/new'
      #raise error message to user letting them know they can not choose existing and create new at same time. 
    when filled_in && params[:new_truck] == "" && params[:truck] != ""
      #create new item and associate with existing truck
      existing_truck = Truck.find_by_id(params[:truck])
      new_item = existing_truck.items.create(name: params[:name], value: params[:value])
      flash[:message] = "New item successfully created and placed in selected truck."
      redirect '/equipment'
    when filled_in && params[:truck] == "" && params[:new_truck] != ""
      #create new item and new truck through association
      new_truck = current_user.trucks.create(name: params[:new_truck])
      new_item = new_truck.items.create(name: params[:name], value: params[:value])
      flash[:message] = "New item and new truck successfully created."
      redirect '/equipment'
    else
      redirect '/equipment/new'
    end
  end

  get '/equipment/:id' do
    @item = Item.find_by_id(params[:id])
    if logged_in? && current_user.id == @item.truck.user.id
      erb :'items/show_item'
    else
      redirect '/login'
    end
  end

  get '/equipment/:id/edit' do
    @item = Item.find_by_id(params[:id])
    if logged_in? && current_user.id == @item.truck.user.id
      erb :'items/edit_item'
    else
      redirect '/login'
    end
  end

  patch '/equipment/:id' do
    if params[:name] != "" && params[:value] !=""
      item = Item.find_by_id(params[:id])
      item.update(name: params[:name], value: params[:value], truck_id: params[:truck_id])
      redirect "equipment/#{item.id}"
      flash[:message] = "Successfully updated equipment."
    else
      redirect "equipment/#{params[:id]}/edit"
    end
  end

  delete '/equipment/:id/delete' do
    item = Item.find_by_id(params[:id])
    if logged_in? && current_user.id == item.truck.user.id
      item.delete
      flash[:message] = "Successfully deleted."
      redirect '/equipment'
    else
      redirect '/login'
    end
  end

  delete '/equipment/delete_all' do
    current_user.trucks.each do |truck|
      truck.items.delete_all
    end
    flash[:message] = "Successfully deleted all equipment."
    redirect '/profile'
  end

end