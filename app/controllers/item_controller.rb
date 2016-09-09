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
    if params[:name] != ""
      new_item = current_user.trucks.create(params)
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
    else
      redirect "equipment/#{params[:id]}/edit"
    end
  end

  delete '/equipment/:id/delete' do
    item = Item.find_by_id(params[:id])
    if logged_in? && current_user.id == item.truck.user.id
      item.delete
      redirect '/equipment'
    else
      redirect '/login'
    end
  end
end