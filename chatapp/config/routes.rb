Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/" => "home#index"
  get "/rooms" => "home#rooms"
  get "/settings" => "home#settings"
  get "/contact" => "home#contact"
  # Defines the root path route ("/")
  # root "articles#index"
end
