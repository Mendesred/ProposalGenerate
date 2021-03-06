Rails.application.routes.draw do
  #resources :hour_extra_role_fields
  # resources :hour_estra_role_fields
  resources :sub_types
  resources :type_equipaments
  resources :meals
  namespace :dashboard do
    resources :admin, except:[:show]
    get 'admins',to:'admin#index'
    post 'admins',to:'admin#create'
  end

  resources :calculations
  resources :equipaments
  resources :services do
    resources :proposals
  end
  resources :services do
    resources :proposal_hour_extras
  end
  resources :rotations
  resources :roles
  resources :services
  resources :periods
  resources :cities
  resources :companies
  devise_for :admins,  :skip => [:registrations]
  devise_for :users
  get 'home/index'

  root 'home#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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
end
