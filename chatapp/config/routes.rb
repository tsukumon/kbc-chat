Rails.application.routes.draw do
  root "home#index"

  get "/room" => "room#index"
  get "/room/joined" => "room#joined"
  get "/search" => "room#search", as: :room_search
  get "/search/rooms" => "room#search_form"
  get "/search/join_rooms" => "room#search_joined", as: :room_search_joined
  get "/room/new" => "room#new_room", as: :new_room
  get "/room/:id" => "room#page", as: :room_page
  
  get "/room/join/:id" => "room#join", as: :room_join
  delete "/room/leave/:id" => "room#leave", as: :room_leave

  post "/room/create" => "room#create_room", as: :create_room
  get "/room/edit/:id" => "room#edit_room", as: :edit_room
  patch "/room/update/:id" => "room#update_room", as: :update_room
  delete "/room/delete/:id" => "room#destroy_room", as: :destroy_room
  post "/message/:id" => "room#create_message", as: :create_message
  delete "/message/:id" => "room#destroy_message", as: :destroy_message

  get "/room_auto/:category" => "room#autocomplete_category"
  get "/name_auto/:name" => "room#autocomplete_name"

  get "/auth/:provider/callback" => "sessions#create"
  get "/auth/failure"=> redirect('/')
  get "/signin" => "sessions#new", as: :new_session
  post "/signout" => "sessions#destroy", as: :destroy_session

  get "/setting" => "settings#index", as: :setting
end
