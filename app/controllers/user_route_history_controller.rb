class UserRouteHistoryController < ApplicationController
  before_action :check_token

  def new
    user = User.find_by(email: params[:useremail])
    unless user
      return render status: 200, json: OpenStruct.new({ status: "fail-no-user"})
    end
    history = UserRouteHistory.create(
      user_id: user.id,
      lat: params[:lat],
      lon: params[:lon],
      place: params[:place]
    )
    render status: 200, json: OpenStruct.new({ status: 200, data: history})
  end

  def my_today_history
    user = User.find_by(email: params[:usermail])
    user_routes = user.user_route_histories.where("created_at >= ?", Time.zone.now.beginning_of_day)
    render status: 200, json: OpenStruct.new({ status: 200, data: user_routes})
  end

  def crime_seen_today
    user = User.find_by(email: params[:usermail])
    user_routes = user.user_route_histories.where("created_at >= ?", Time.zone.now.beginning_of_day)
    today_crimes = Crime.where("created_at >= ?", Time.zone.now.beginning_of_day)
    crimes = []
    user_routes.each do |route|
      crimes = today_crimes.all.select do |c|
        distance = Crime.get_distance([route.lat.to_f, route.lon.to_f],[c.lat.to_f, c.lon.to_f])
        distance <= params[:distance].to_i
      end
    end
    render status: 200, json: OpenStruct.new({ status: 200, data: crimes})

  end

  def my_all_history
    user = User.find_by(email: params[:usermail])
    user_routes = user.user_route_histories
    render status: 200, json: OpenStruct.new({ status: 200, data: user_routes})
  end

  def all_history
    all_routes = UserRouteHistory.all
    render status: 200, json: OpenStruct.new({ status: 200, data: all_routes})
  end

  private

  def check_token
    list = Iplist.find_or_create_by(ip: request.remote_ip, date: Date.today)
    p "-------------------------"
    p request.user_agent
    p "-------------------------"
    p request.user_agent =~ /iOS/
    list.update(count: list.count + 1)
    # if list.count > 1000
    #   return render status: 500, json: OpenStruct.new({ status: 500, message: "fuck fuck fuck"})
    # end

    unless request.user_agent =~ /iOS/
      p "not ios"
      return render status: 200, json: OpenStruct.new({ status: 500, message: "fuck fuck"})
    end
    if params[:token] != "RV2HP71Kzpsv73z6FLt8OFZS9zM4s254"
      p "no token"
      return render status: 200, json: OpenStruct.new({ status: 500, message: "fuck"})
    end

  end

end
