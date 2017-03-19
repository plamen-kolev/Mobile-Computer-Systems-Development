Rails.application.routes.draw do
  devise_for :users
  match '/connections/confirm', to: 'connections#confirm', as: 'connection_confirm', :via => :post

  resources :connections

  get '/conversations/:id', to: 'conversations#show', as: 'conversation'
  get '/conversations/:id/json', to: 'conversations#show_json', as: 'conversation_json'

  root 'pages#index'
end
