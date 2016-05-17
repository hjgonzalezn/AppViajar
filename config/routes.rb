Rails.application.routes.draw do

  get 'entidad_territorials/actualizar_lista_dependiente' => 'entidad_territorials#actualizar_lista_dependiente', as: :actualizar_lista_dependiente
  get 'empresas/buscar_datos_empresa' => 'empresas#buscar_datos_empresa', as: :buscar_datos_empresa
  get 'personas/buscar_datos_persona' => 'personas#buscar_datos_persona', as: :buscar_datos_persona
  
  resources :sucursal_empresas
  resources :sucursal_empresas
  resources :personas
  resources :empresas
  resources :vehiculos

  resources :entidad_territorials
  resources :division_pais
  resources :regions
  resources :unidad_territorials
  resources :aeropuertos
  resources :catalogos
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'about#index'
  get 'about' => 'about#index', as: :home
  get 'about/datos_reserva' => 'about#datos_reserva'
  get 'about/admon' => 'about#admon', as: :administracion
  
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
