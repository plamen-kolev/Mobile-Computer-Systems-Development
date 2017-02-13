Rails.application.routes.draw do
  devise_for :users
  resources :connections

  get '/conversations/:partner_id', to: 'conversations#show', as: 'conversation'
  root 'pages#index'
end
