
json.id              @user.id
json.email           @user.email
json.point           @user.point
json.route_histories @user.user_route_histories
json.activities      @user.user_activities
json.items do
  json.array! @user.user_items do |item|
    json.id              item.id
    json.point           item.store_discount.try(:point)
    json.discount        item.store_discount.try(:discount)
    json.store           item.store_discount.try(:store)
    json.description     item.store_discount.try(:description)
    json.used            item.used
  end
end