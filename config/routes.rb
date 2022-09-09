Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/restaurants/:id/kitchen", to: "restaurants#kitchen", as: "kitchen"
  get "order_items/:id", to: "order_items#prepared!", as: "prepared"
  get "tables/:table_id/order_items/:id", to: "order_items#served!", as: "served"
  get "/restaurants/:id/menus/:id/activated", to: "menu#activated", as: "activated"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :join_menus, only: :destroy
  resources :restaurants do
    resources :restaurant_servers
    resources :menu_items
    resources :menus do
      resources :join_menus, only: %i[show new create]
    end
    resources :tables do
      resources :table_orders do
        resources :table_customers do
          resources :order_items
        end
      end
    end
  end
end
