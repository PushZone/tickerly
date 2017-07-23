class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
    @stores = Store.count
    @crimes = Crime.count

  end

  def store
    @stores = Store.all
    @today_crimes = Crime.where("created_at >= ?", Time.zone.now.beginning_of_day).where.not(created_by: nil)
    @hash = Gmaps4rails.build_markers(@crimes) do |crime, marker|
      marker.lat crime.lat
      marker.lng crime.lon
    end
  end

  def get_store
    @stores = Store.all.order('id DESC')
    # render status: 200, json: OpenStruct.new({ status: 200, data: @stores})
  end

  def add_new_store
    @store = Store.create(name: params[:name], lat: params[:lat], lon: params[:lon], description: params[:description])
    render status: 200, json: OpenStruct.new({ status: 200, data: @store})
  end

  def add_store_item
    @item = StoreDiscount.create(
      name: params[:name],
      store_id: params[:id],
      discount: params[:discount],
      point: params[:point],
      description: params[:description]
    )
    render status: 200, json: OpenStruct.new({ status: 200, data: @item})
  end

  def edit_store
    store = Store.find_by(id: params[:id])
    store.update(name: params[:name], lat: params[:lat], lon: params[:lon], description: params[:description])
    store.save
    render status: 200, json: OpenStruct.new({ status: 200, data: ""})
  end

  def remove_store
    Store.find_by(id: params[:id]).destroy
    render status: 200, json: OpenStruct.new({ status: 200, data: ""})
  end

  def remove_store_item
    StoreDiscount.find_by(id: params[:id]).destroy
    render status: 200, json: OpenStruct.new({ status: 200, data: ""})
  end


  def crime
    @crimes = Crime.all
    @today_crimes = Crime.where("created_at >= ?", Time.zone.now.beginning_of_day).where.not(created_by: nil)
    @hash = Gmaps4rails.build_markers(@crimes) do |crime, marker|
      marker.lat crime.lat
      marker.lng crime.lon
    end

  end

  def get_crime
    @crimes = Crime.all.order('id DESC')
  end

  def add_new_crime
    user = User.find(current_user["id"])
    crime = Crime.create(
      crime_type: params[:type],
      lat: params[:lat],
      lon: params[:lon],
      location_name: params[:location],
      user_id: user.id,
      created_by: user.name,
      crime_name: params[:crime_name],
      crime_image_link: params[:crime_image_link],
      desc: params[:desc]
    )

    user.update(point: user.point + 10)
    UserActivity.create(
      user_id: user.id, 
      crime_id: crime.id,  
      crime_type: params[:crimetype],
      lat: params[:latitude],
      lon: params[:longitude],
      location_name: params[:locationName],   
      activity_type: 1,
      point: 10)
    render status: 200, json: OpenStruct.new({ status: 200, data: crime})

  end

  def remove_crime
    Crime.find_by(id: params[:id]).destroy
    render status: 200, json: OpenStruct.new({ status: 200, data: ""})
  end

end
