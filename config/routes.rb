Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :restaurants do
    resources :menus, only: :destroy
    resources :restaurant_servers
    resources :menu_items
    resources :menus, except: :destroy do
      resources :join_menus
    end
    resources :tables do
      resources :table_orders do
        resources :table_customers do
          resources :orders
        end
      end
    end
  end
end
