Rails.application.routes.draw do
  resources :edit_plays
  get "/plays/:play" => "plays#show"

  post "/plays/save" => "plays#save"

  get 'home/homepage'

  root 'home#homepage'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
