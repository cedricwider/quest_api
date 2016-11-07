Rails.application.routes.draw do
  post '/logins', to: 'logins#create'
  post '/query', to: 'queries#create'

  resources :quests
  resources :clans
  resources :users
end
