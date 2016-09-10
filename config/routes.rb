Rails.application.routes.draw do

  resources :fotos
  resources :controls
  resources :accions
  resources :modelos
  resources :viajes
  get 'entidad_territorials/actualizar_lista_dependiente' => 'entidad_territorials#actualizar_lista_dependiente', as: :actualizar_lista_dependiente
  get 'empresas/buscar_datos_empresa' => 'empresas#buscar_datos_empresa', as: :buscar_datos_empresa
  get 'personas/buscar_datos_persona' => 'personas#buscar_datos_persona', as: :buscar_datos_persona
  get 'catalogos/cargar_registros_catalogo' => 'catalogos#cargar_registros_catalogo', as: :cargar_registros_catalogo
  get 'about' => 'about#index', as: :home
  get 'about/mensaje' => 'about#mensaje', as: :mensaje
  get 'about/detalle_reserva' => 'about#detalle_reserva', as: :detalle_reserva
  post 'about/detalle_reserva' => 'about#detalle_reserva'
  get 'paquete_turisticos/:id/detalle_plan/' => 'paquete_turisticos#detalle_plan', as: :detalle_plan_turistico
  post 'paquete_turisticos/:id/detalle_plan/' => 'paquete_turisticos#detalle_plan'
  post 'about/registrar_reserva' => 'about#registrar_reserva'
  post 'about/confirmar_reserva' => 'about#confirmar_reserva' 
  get 'about/confirmar_reserva' => 'about#confirmar_reserva'
  get 'about/admon' => 'about#admon', as: :administracion
  get 'about/somos' => 'about#somos', as: :somos
  get 'about/ofertas' => 'about#ofertas', as: :ofertas
  post 'about/mensaje_contacto' => 'about#mensaje_contacto'
  get 'about/mensaje_contacto' => 'about#mensaje_contacto', as: :mensaje_contacto
  get 'about/contacto' => 'about#contacto', as: :contactenos
  get 'about/reservas' => 'about#reservas', as: :reservas
  get 'about/planes' => 'about#planes', as: :planes  
  get 'about/carga' => 'about#carga', as: :carga
  get 'about/alojamiento' => 'about#alojamiento', as: :alojamiento  
  
  resources :empresas do
    resources :sucursal_empresas  
  end
  
  resources :vehiculos do
    resources :tarifas
  end
  
  resources :paquete_turisticos do
    resources :tarifas
  end
  
  resources :ruta do
    resources :tarifas
  end
  
  resources :aeropuertos
  resources :catalogos  
  resources :division_pais
  resources :entidad_territorials
  resources :personas
  resources :regions
  resources :sucursal_empresas
  resources :tarifas  
  resources :tipo_actividad_turisticas
  resources :unidad_territorials
  
    
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'about#index'
  
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
