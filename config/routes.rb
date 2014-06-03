RELREA::Application.routes.draw do

  get "dashboard/index"
  get "infos/index"
  get "manage_values/index"
  get "weights/index"
  get "mfunctions/index"
  get "charts/index"
  resources :home
  resources :test
  resources :charts
 
  resources :dashboard do
    member do
        post 'show'
        post 'save'
    end
  end
  resources :infos do
    member do
        post 'index'
        post 'save'
    end
  end
  resources :mfunctions do
    member do
        post 'show'
    end
  end
  
  resources :weights do
    member do
        post 'show'
    end
  end
  
  resources :settings
  resources :manage_values do
    member do
      post 'new'
    end
  end
  get "home/index"


  namespace :data_service do 
    resources :datasources do
    member do
        post 'show'
        post 'save'
    end
  end
end
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
