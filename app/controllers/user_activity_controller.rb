class UserActivityController < ApplicationController
  before_action :check_token

  def get_user_activity
    user = User.find_by(id: params[:user_id])
    return render status: 500, json: OpenStruct.new({ status: "fail-no-user"}) if user.email.nil?
    activities = UserActivity.where(user_id: params[:user_id])
    render status: 200, json: OpenStruct.new({ status: 200, data: activities})
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
