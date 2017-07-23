json.users do
  json.array! @users do |user|
    json.id              user.id
    json.email           user.email
    json.point           user.point
    json.route_histories user.user_route_histories
    json.activities      user.user_activities
    json.items           user.user_items
  end
end