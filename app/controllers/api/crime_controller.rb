class Api::CrimeController < ApplicationController
  # before_action :check_token

  def index
    @crimes = Crime.all.order('id DESC')
  end

  def today
    @crimes = Crime.where("created_at >= ?", Time.zone.now.beginning_of_day).order('id DESC')
  end

  def show
    @crime = Crime.find(params[:id])
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
