Rails.application.routes.draw do
 match "/", to: redirect("/api/v1"), via: :all
  namespace :api do
    namespace :v1 do
      root to: 'home#first_page'
        post 'user/sign_up', to: "auth#sign_up"
        post 'user/sign_in', to: "auth#sign_in"
        delete 'user/sign_out', to: "auth#sign_out"
        get 'user/profile', to: "users#profile"
        patch 'user/:id/update', to: "users#update"
        get 'user/vendor/:id', to: "users#vendor"
        get 'products', to: 'products#index'
        get "product/:id", to: 'products#show'
        patch "product/:id", to: "products#update"
        delete "product/:id", to: "products#destroy"
        get 'user/order_form', to: "order_templates#order_form"
        get 'users', to: "users#index"
        get 'order/:id/send_mail', to: "orders#send_mail"
        get 'vendor/:id/orders', to: "orders#vendor_orders"
        post 'user/:id/change_password', to: "users#change_password"
        post 'password/forgot', to: "passwords#forgot"
        post 'password/reset', to: "passwords#reset"
        resources :users, only: [:show] do
          resources :products, only: [:show, :index, :new, :create, :update, :edit]
        end
        resources :users, only: [:show] do
          resources :order_templates, only: [:show, :index, :new, :create, :update, :edit, :destroy]
        end
        resources :users, only: [:show] do
          resources :orders, only: [:show, :index, :new, :create, :update, :edit, :destroy]
        end
    end
  end

 match "*unmatched", to: "api/v1/errors#not_found", via: :all
 match "/500", to: "api/v1/errors#internal_server_error", via: :all
  
end

