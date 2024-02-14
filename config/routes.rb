Rails.application.routes.draw do
  get '/' => 'home#top'
  get 'main' => 'home#main'
  post 'upload' => 'home#upload'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
