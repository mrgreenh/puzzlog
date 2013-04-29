FragmentsProject::Application.routes.draw do
  get "puzzle_box/show"

  root to: 'static_pages#home'
  
  resources :users
  resources :user_role_relationships, only: [:create, :destroy]
  resources :sessions, only:[:new,:create,:destroy]
  
  resources :articles
  match 'articles/:id/publish', to: 'articles#publish', as: 'publish_article'
  match 'articles/:id/unpublish', to: 'articles#unpublish', as: 'unpublish_article'
  
  resources :pages, only: [:show,:create,:destroy,:edit]
  resources :page_fragment_relationships, only: [:new,:create,:update,:destroy]
  match 'page_fragment_relationships/move_fragment_to_page', to: 'page_fragment_relationships#move_fragment_to_page', as: 'move_fragment_to_page'
  match 'articles/:article_id/:page_number', to: 'pages#show'
  
  #Fragments
  resources :fragments
  match 'fragments/add_to_puzzle_box/:id', to:'fragments#add_to_puzzle_box', as: 'add_fragment_to_puzzle_box'
  match 'fragments/remove_from_puzzle_box/:id', to:'fragments#remove_from_puzzle_box', as: 'remove_fragment_from_puzzle_box'
  
  #Other pages
  match '/streamline', to: 'static_pages#streamline', as: 'streamline'
  
  match '/staff', to: 'users#index'
  
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'
  
  #Fragment Resources
  resources :fragment_images
  resources :fragment_image_relationships, only: [:new]
  resources :fragment_types, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  
  #PuzzleBox
  match '/box', to:'box#show'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
