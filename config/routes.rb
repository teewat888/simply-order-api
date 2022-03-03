Rails.application.routes.draw do
 match "/", to: redirect("/api/v1"), via: :all
  namespace :api do
    namespace :v1 do
      root to: 'home#first_page'
        post 'user/sign_up', to: "users#sign_up"
        post 'user/sign_in', to: "auth#sign_in"
        delete 'user/sign_out', to: "auth#sign_out"
        get 'user/profile', to: "users#profile"
        #remove test controller later
        post 'test', to: "test#test_page"
        get 'products', to: 'products#index'
    end
  end

 match "*unmatched", to: "api/v1/errors#not_found", via: :all
 match "/500", to: "api/v1/errors#internal_server_error", via: :all
  
end

