Rails.application.routes.draw do


  root 'pages#index'
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # scope "/:locale" do
  scope "/api" do
    # resources :connections, param: :connection_id do
    get 'connections', to: 'connections#index'
    get 'connections/:connection_id/messages', to: 'connections#show_messages'
    get 'connections/:connection_id', to: 'connections#show'

    get 'connections/:connection_id/messages/:message_id', to: 'connections#message'
    post 'connections/:connection_id/messages/send',  to: 'connections#send_message'
    post 'connections/:connection_id/confirm', to: 'connections#confirm'

    # emoticon endpoints
    get 'emoticons/:type', to: 'content#emoticons'

    # end

    get 'users', to: 'connections#users', as: 'users'
    # post 'connections/confirm', to: 'connections#confirm', as: 'confirm'
    post 'auth' => 'user_token#create'
    # get 'categories/', to: 'api#categories', as: 'categories'
    # get 'categories/:category_id/products', to: 'api#category_products', as: 'category_products'
    # get 'categories/:category_id', to: 'api#category', as: 'category'
    #
    # get 'products', to: 'api#products', as: 'products'
    # get 'products/:product_id', to: 'api#product', as: 'product'
  end
  # end
end
