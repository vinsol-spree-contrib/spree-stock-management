Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :admin, path: Spree.admin_path do
    resources :stock_items do
      collection { post :import }
      collection { get :sample_csv }
    end
  end

end
