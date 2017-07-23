class HomeController < ApplicationController
  def no_content
    render status: 200, json: OpenStruct.new({ status: 200, message: "fuck"})
  end

  def index
    @crimes = Crime.all
    @today_crimes = Crime.where("created_at >= ?", Time.zone.now.beginning_of_day).where.not(created_by: nil)
    @hash = Gmaps4rails.build_markers(@crimes) do |crime, marker|
      marker.lat crime.lat
      marker.lng crime.lon
    end

  end

  

end
