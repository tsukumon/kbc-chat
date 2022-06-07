Rails.application.routes.draw do
  get "/" => "home#index"

  get "/room" => "room#index"
  get "/room/new" => "room#new_room", as: :new_room
  get "/room/:id" => "room#page", as: :room_page

  post "/room/create" => "room#create_room", as: :create_room
  get "/room/edit/:id" => "room#edit_room", as: :edit_room
  patch "/room/update/:id" => "room#update_room", as: :update_room
  delete "/room/delete/:id" => "room#destroy_room", as: :destroy_room
  post "/message/:id" => "room#create_message", as: :create_message
  delete "/message/:id" => "room#destroy_message", as: :destroy_message

end
