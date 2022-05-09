Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/" => "home#index"
  # Defines the root path route ("/")
  # root "articles#index"

  get "/room" => "room#index"
  get "/room/new" => "room#new"
  post "/room/create" => "room#create_room"
end
