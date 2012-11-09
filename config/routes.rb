RouterTester::Application.routes.draw do
  # Define the root route to display the index action of ManagersController
  root :to => "managers#index"

  #Add a resources declaration for a resource named companies.
  # Observe that seven routes are added following the RESTful convention
  resources :companies

  # Add a second set of resources named managers and observe
  # the routes increase to 14
  resources :managers do
    # Add a custom route that will trigger the generate_statistics action of
    # 'ManagersController' when a GET is submitted to generate_statistics_managers_path
    get 'generate_statistics', :on => :collection
  end
  #Add a route that will redirect requests for /bosses to /managers
  match "bosses" => "managers#index", :via => :get
  #Add another that redirects show requests like /bosses/16 to /managers/16
  match "bosses/:id" => "managers#show", :via => :get, :as => :boss

  # Add nested evaluations resources underneath employees. Make sure that
  # you have routes generated like employee_evaluations_path
  # Add nested scores resources underneath evaluations. Observe how the
  # route names get insane, and reflect on how these nested resources are
  # just not worth it.
  resources :employees do
    resources :evaluations do
      resources :scores
    end

    # Add a custom route that will trigger the promote action of
    # EmployeesController when a PUT is submitted to promote_employee_path
    put 'promote', :on => :member
  end

    # Add a route named directory that points to
    # the index action of EmployeesController
    match "directory" => "employees#index", :via => :get

    # Add a route named search that points to the
    # new action of the SearchesController
    match "search" => "searches#new", :via => :get

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
