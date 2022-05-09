Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/" => "home#index"
  # Defines the root path route ("/")
  # root "articles#index"

  get "/room" => "room#index"
  get "/room/new" => "room#new_room"
  post "/room/create" => "room#create_room"
  post "/room/destroy/#{:id}" => "room#destroy_room"
end
