Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #mount ActionCable.server => '/cable'
  #top page
  get "/" => "home#index"

  #rooms
  get "/room" => "room#index"
  get "/room/new" => "room#new"
  post "/room/create" => "room#create"
  delete "/room/delete/:id" => "room#destroy"
  #delete "/message/delete/:id" => "message#destroy"

  #room page
  get "/room/:id" => "room#page"
  post "/message/:id" => "message#create"
  delete "/message/delete/:id" => "message#destroy"


end
