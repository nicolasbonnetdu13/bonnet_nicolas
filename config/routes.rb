MyBlog::Application.routes.draw do
  
  constraints(:host => /^bonnet-nicolas.com/) do
    root :to => redirect("http://www.bonnet-nicolas.com")
    match '/*path', :to => redirect {|params| "http://www.bonnet-nicolas.com/#{params[:path]}"}
  end
  
  get "myProjects" => 'static_pages#myProjects'
  get "about" => 'static_pages#about'
  get "aboutMe" => 'static_pages#aboutMe'
  get "download_cv" => 'static_pages#download_cv'
  get "download_high_quality_cv" => 'static_pages#download_high_quality_cv'
  resources :gallery_images

  root to: "posts#index"
  
  devise_for :users
  resources :posts 
  resources :comments, :only => [:create, :destroy]
  
  match 'like' => 'users#like', :via => [:get]
  match 'unlike' => 'users#unlike', :via => [:get]
  
  match "/posts/add_new_comment" => "posts#add_new_comment", :as => "add_new_comment_to_posts", :via => [:post]
  
  match "posts/tagged/:tag" => 'posts#tagged', :via => [:get],  :as => 'tagged_blog_posts'
  
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
