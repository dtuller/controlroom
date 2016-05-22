Rails.application.routes.draw do

  root "scenes#index"

  # Routes for the Lightbulb resource:
  # CREATE
  get "/lightbulbs/new", :controller => "lightbulbs", :action => "new"
  post "/create_lightbulb", :controller => "lightbulbs", :action => "create"

  # READ
  get "/lightbulbs", :controller => "lightbulbs", :action => "index"

  # UPDATE
  get "/lightbulbs/:id/edit", :controller => "lightbulbs", :action => "edit"
  post "/update_lightbulb/:id", :controller => "lightbulbs", :action => "update"

  # DELETE
  get "/delete_lightbulb/:id", :controller => "lightbulbs", :action => "destroy"

  get "/import_lightbulbs", :controller => "lightbulbs", :action => "import"

  get "/hue_lightbulbs/:id/test", :controller => "lightbulbs", :action => "test"

  get "/lightbulbs/:control_id/turn_on", :controller => "lightbulbs", :action => "turn_on_lightbulb"
  get "/lightbulbs/:control_id/turn_off", :controller => "lightbulbs", :action => "turn_off_lightbulb"

#------------------------------

  # Routes for the State resource:
  # CREATE
  get "/states/new", :controller => "states", :action => "new"
  post "/create_state", :controller => "states", :action => "create"

  # READ
  get "/states", :controller => "states", :action => "index"
  get "/states/:id", :controller => "states", :action => "show"

  # UPDATE
  get "/states/:id/edit", :controller => "states", :action => "edit"
  post "/update_state/:id", :controller => "states", :action => "update"

  # DELETE
  get "/delete_state/:id", :controller => "states", :action => "destroy"
  #------------------------------

  # Routes for the Scene_lightbulb_state resource:
  # CREATE
  get "/scene_lightbulb_states/new", :controller => "scene_lightbulb_states", :action => "new"
  post "/create_scene_lightbulb_state", :controller => "scene_lightbulb_states", :action => "create"

  # READ
  get "/scene_lightbulb_states", :controller => "scene_lightbulb_states", :action => "index"
  get "/scene_lightbulb_states/:id", :controller => "scene_lightbulb_states", :action => "show"

  # UPDATE
  get "/scene_lightbulb_states/:id/edit", :controller => "scene_lightbulb_states", :action => "edit"
  post "/update_scene_lightbulb_state/:id", :controller => "scene_lightbulb_states", :action => "update"

  # DELETE
  get "/delete_scene_lightbulb_state/:id", :controller => "scene_lightbulb_states", :action => "destroy"
  #------------------------------

  # Routes for the Scene resource:
  # CREATE
  get "/scenes/new", :controller => "scenes", :action => "new"
  post "/create_scene", :controller => "scenes", :action => "create"

  # READ
  get "/scenes", :controller => "scenes", :action => "index"
  get "/scenes/:id", :controller => "scenes", :action => "show"

  # UPDATE
  get "/scenes/:id/edit", :controller => "scenes", :action => "edit"
  post "/update_scene/:id", :controller => "scenes", :action => "update"

  # DELETE
  get "/delete_scene/:id", :controller => "scenes", :action => "destroy"
  #------------------------------

  # Routes for the Room resource:
  # CREATE
  get "/rooms/new", :controller => "rooms", :action => "new"
  post "/create_room", :controller => "rooms", :action => "create"

  # READ
  get "/rooms", :controller => "rooms", :action => "index"
  get "/rooms/:id", :controller => "rooms", :action => "show"

  # UPDATE
  get "/rooms/:id/edit", :controller => "rooms", :action => "edit"
  post "/update_room/:id", :controller => "rooms", :action => "update"

  # DELETE
  get "/delete_room/:id", :controller => "rooms", :action => "destroy"
  #------------------------------

  devise_for :users
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
