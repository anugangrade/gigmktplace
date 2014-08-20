Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks",:registrations => "registrations" }

  resources :gigs do 
    member do 
      post "purchase"
      get "confirm_order"
      get "bookmark"
      post "rate_it"
    end
    resources :extragigs
  end

  get 'home/index'
  post '/search' => 'home#index', as: "search"
  get '/categories/:category_url' => "home#search_by_category", :as => 'search_by_category'
  get '/categories/:category_url/:subcategory_url' => "home#search_by_subcategory", as: "search_by_subcategory"
  
  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  
  get '/conversation/:id' => 'users#conversation', :as => "conversation"
  get '/conversations' => 'users#conversations', :as => "conversations"
  get '/download_file/:id' => 'users#download_file', :as => "download_file"
  post '/user/save_message' => "users#save_message"
  get '/my_collection' => "users#collection"
  post '/my_collection' => "users#collection"
  
  get '/users/:username/orders' => "users#orders", as: "orders"
  get '/users/:username/orders/:order_number' => "users#order_messages", as: "order_messages"
  post '/users/save_order_message' => "users#save_order_message", as: "save_order_message"
  get 'purchase/order_complete/:id' => "users#order_complete", as: "order_complete"
  post 'save_review' => "users#save_review", as: "save_review"
  post 'save_reply' => "users#save_reply", as: "save_reply"

  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root to: "home#index"
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:l
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  get '/:username/:url' => 'gigs#show', as: 'show_gig'
  get '/:username' => 'users#profile', :as=>"profile"
end
