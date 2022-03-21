Rails.application.routes.draw do
 match "/", to: redirect("/api/v1"), via: :all
  namespace :api do
    namespace :v1 do
      root to: 'home#first_page'
        post 'user/sign_up', to: "auth#sign_up"
        post 'user/sign_in', to: "auth#sign_in"
        delete 'user/sign_out', to: "auth#sign_out"
        get 'user/profile', to: "users#profile"
        get 'user/vendor/:id', to: "users#vendor"
        get 'products', to: 'products#index'
        get "product/:id", to: 'products#show'
        patch "product/:id", to: "products#update"
        delete "product/:id", to: "products#destroy"
        get 'user/order_form', to: "order_templates#order_form"
        get 'users', to: "users#index"
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

