class Api::StoreController < ApplicationController
  # before_action :check_token

  def index
    @stores = Store.all.order('id DESC')
  end

  def show
    @store = Store.find(params[:id])
  end

  def get_item
    user = User.find_by(email: params[:useremail])
    unless user
      return render status: 200, json: OpenStruct.new({ status: "fail-no-user"})
    end
    discount = StoreDiscount.find_by(id: params[:item_id])
    if user.point > discount.point
      UserItem.create(user_id: user.id, store_discount_id: discount.id)
      user.update(point: user.point - discount.point)
      render status: 200, json: OpenStruct.new({ status: 200, message: "success"})
    else
      render status: 200, json: OpenStruct.new({ status: 500, message: "need more point"})
    end
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
