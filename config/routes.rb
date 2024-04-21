Rails.application.routes.draw do
  namespace :public do
    get 'orders/new', to: 'orders#new', as: 'new_order_input'
    post 'orders/new_confirmation', to: 'orders#new_confirmation', as: 'new_order_confirmation'
    get 'orders/:id', to: 'orders#show', as: 'show_order'
    post 'orders/create', to: 'orders#create', as: 'create_order'
    get 'orders', to: 'orders#index', as: 'order_history'
    get 'orders/order_details/:id', to: 'orders#show_details', as: 'order_details'
  end

  namespace :public do
    get 'cart_items', to: 'cart_items#index', as: 'cart_items'
    patch 'cart_items/:id', to: 'cart_items#update', as: 'update_cart_item'
    delete 'cart_items/:id', to: 'cart_items#destroy', as: 'destroy_cart_item'
    delete 'cart_items', to: 'cart_items#destroy_all', as: 'destroy_all_cart_items'
    post 'cart_items', to: 'cart_items#create', as: 'create_cart_item'
  end
  namespace :public do
    get  'customers/check', to: 'customers#check', as: 'check_customer'
    patch  'customers/withdraw', to: 'customers#withdraw', as: 'withdraw_customer'
    get 'customers/:id', to: 'customers#show', as: 'customer'
    get 'customers/:id/edit', to: 'customers#edit', as: 'edit_customer'
    patch 'customers/:id', to: 'customers#update', as: 'update_customer'

  end
  namespace :public do
    get 'items', to: "items#index", as: "item"
    get 'items/:id', to: "items#show", as: "show_item"
  end
  namespace :public do
    get '/', to: "homes#top", as: "top_customer"
    get 'homes/about', to: "homes#about", as: "about"
  end
  namespace :admin do
    get '/', to: 'homes#top', as: 'top'
  end
  namespace :admin do
    get 'orders/ordercontroller/:id', to: 'orders#show', as: 'ordercontroller'
  end
  namespace :admin do
    get 'customers', to: 'customers#index', as: 'customer'
    get 'customers/:id', to: 'customers#show', as: 'show_customer'
    get 'customers/:id/edit', to: 'customers#edit', as: 'edit_customer'
    patch 'customers/:id', to: 'customers#update', as: 'update_customer'
  end
  namespace :admin do
    get 'items', to: 'items#index', as: 'item_list'
    get 'new', to: 'items#new', as: 'new_item'
    post 'create', to: 'items#create', as: 'create_item'
    get 'items/:id', to: 'items#show', as: 'show_item'
    get 'items/:id/edit', to: 'items#edit', as: 'edit_item'
    patch 'items/:id', to: 'items#update', as: 'update_item'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :customers, skip:[:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  root to: 'public/homes#top'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
