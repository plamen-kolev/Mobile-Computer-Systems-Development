Rails.application.routes.draw do
  devise_for :users
  match '/connections/confirm', to: 'connections#confirm', as: 'connection_confirm', :via => :post

  resources :connections
  resources :conversations, param: :channel

  post 'token' => "tokens#create"
  get 'token' => "tokens#create"
  post 'update_last_read' => 'conversations#update_last_read'

  post "send_negative_emoticon" => 'conversations#send_negative_emoticon'
  
  get 'render_rude_emoticons/:channel' => 'conversations#render_rude_emoticons'
  get 'render_good_emoticons/' => 'conversations#render_good_emoticons'

  post "delete_message" => "conversations#delete_message"

  root 'pages#index'
end
