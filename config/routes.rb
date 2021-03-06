Rails.application.routes.draw do

  devise_for :managers
  devise_for :people
  mount IncidentV1::GrapeAPI => '/v1'
  resources :incidents
  root "incidents#index"

  namespace :dashboard do
    namespace :admin do
      resources :people
      resources :incidents
      resources :cates
    end  
  end

  resources :conversations do
    resources :messages
  end
   
  get "/update_group" => "incidents#update_group"
  get "/update_incident" => "incidents#update_incident"
  get "/index" => "incidents#index"
  get 'apidoc/menu'
  get 'apidoc/overview'
  get 'apidoc/start'
  get 'apidoc/sample'
  get 'apidoc/reference'
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
