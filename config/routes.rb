Rails.application.routes.draw do
  post '/logins', to: 'logins#create'

  resources :quests
  resources :clans
  resources :users
end
