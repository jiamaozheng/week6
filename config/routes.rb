Rails.application.routes.draw do

  root 'flights#index'
  resources :flights, only: [:index, :destroy]
  post "/flights/:id/share" => 'flights#share', as: :flight_share


  # New routes for Week 6

  get  '/auth/:provider/callback' => 'sessions#create'
  post '/auth/:provider/callback' => 'sessions#create'


  # This pseudo-route is automatically provided for us by the omniauth gem:
  # get '/auth/:developer' => omniauth gem
  # get '/auth/:provider' => twitter.com

end
