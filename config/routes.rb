Rails.application.routes.draw do

  devise_for :users
  # get '*', :to => 'home#no_content'
  # post '*', :to => 'home#no_content'
  get 'sessions/create'
  get 'sessions/destroy'


root :to => "home#index"

get  'admin', :to => 'admin#index'
get  'admin/crime', :to => 'admin#crime'
post 'admin/crime', :to => 'admin#add_new_crime'
put  'admin/crime/:id', :to => 'admin#remove_crime'

get 'admin/store', :to => 'admin#store'
get 'admin/get_store', :to => 'admin#get_store'
get 'admin/get_crime', :to => 'admin#get_crime'
post 'admin/store', :to => 'admin#add_new_store'
post 'admin/store/:id/item', :to => 'admin#add_store_item'

post 'admin/store/:id/edit', :to => 'admin#edit_store'

put 'admin/store/:id', :to => 'admin#remove_store'
put 'admin/store/item/:id', :to => 'admin#remove_store_item'


# CRIME API---------------------------------------
get  'api/crime', :to => 'api/crime#index'
get  'api/crime/today', :to => 'api/crime#today'
get  'api/crime/:id', :to => 'api/crime#show'
#-------------------------------------------------

# STORE API---------------------------------------
get  'api/store', :to => 'api/store#index'
get  'api/store/:id', :to => 'api/store#show'

post  'api/store/get_item/:item_id', :to => 'api/store#get_item'
#-------------------------------------------------

# User API----------------------------------------
get  'api/users', :to => 'api/user#index'
get  'api/users/:id', :to => 'api/user#show'


#-------------------------------------------------


post 'crime/new' => 'crime#new_crime'
post 'crime/get_near' => 'crime#get_near'
post 'crime/createuser' => 'crime#new_user'
post 'crime/createuseremail' => 'crime#new_user_email'
post 'crime/sendusername' => 'crime#get_username'
post 'crime/:id/verify_approve' => 'crime#verify_approve'
post 'crime/:id/verify_unapprove' => 'crime#verify_unapprove'

post 'crime/:id/get_unapprove' => 'crime#get_unapprove'
post 'crime/:id/get_approve' => 'crime#get_approve'


post 'activity/:user_id' => 'user_activity#get_user_activity'


post 'history/new' => 'user_route_history#new'
post 'history/my_today' => 'user_route_history#my_today_history'
post 'history/my_all' => 'user_route_history#my_all_history'
post 'history/all' => 'user_route_history#all_history'
post 'history/crime_seen_today' => 'user_route_history#crime_seen_today'


end