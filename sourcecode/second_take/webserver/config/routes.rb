Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'pages#index'
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # scope "/:locale" do
  scope "/api" do
    get 'connections' => 'connections#index'
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
