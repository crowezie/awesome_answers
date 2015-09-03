Rails.application.routes.draw do

  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
    # this will create for us a route with DELETE http vern and /sessions. Adding on: :collection as an option will make it part of the routes for sessions which means it won't prepend the routes with /sessions/:session_id
  end

  resources :users, only: [:new, :create] do
    get :edit, on: :collection
    patch :update, on: :collection
  end



  resources :questions do
    resources :answers, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :votes, only: [:create, :update, :destroy]
  end

  resources :answers, only: [] do
    resources :comments, only: [:create, :destroy]
  end



  patch "/questions/:id/lock" => "questions#lock", as: :lock_question
# This will match any get request to a URL /questions/new to the questions controller
# and new action within that controller. Adding the as: :new_question option enables
# us to have a handy URL helper method that we can use in the views and controllers
#  (i.e. look at our link_to path). The method in this case will be new_question_path
#  or new_question_url
#nesting recources within the other resources makes every URL for answers prepended with /questions/:question_id
resources :questions do
  resources :answers, only: [:create, :destroy]
end

resources :answers, only: [] do
  resources :comments, only: [:create, :destroy]
end



  #post "/questions/:question_id/answers" => "answers#create"
  # get "/questions/new" => "questions#new", as: :new_question
  # post "/questions" => "questions#create", as: :questions
  #
  # get "/questions/:id" => "questions#show", as: :question
  #
  # get "/questions" => "questions#index"
  #
  # get "/questions/:id/edit" => "questions#edit", as: :edit_question
  #
  # patch "/questions/:id" => "questions#update"
  # delete "/questions/:id" => "questions#destroy"
  #
  # # this will match a GET request to "/hello" url
  # # It will invoke the index method (which is called an action)
  # within WelcomeController which is located in app/controllers folder
  get "/hello" => "welcome#index"
  get "/contact" => "contact#index"
  post "/contact" => "contact#create"

  get "/subscribe" => "subscribe#index"
  post "/subscribe" => "subscribe#create"


# This will match any url /hello/something with GET request
# When linking internally can use both path or url, when providing a link externally (such as an email) you must use URL
  get "/hello/:name" => "welcome#hello", as: :greet # to give a helper path

# this sets the homepage. The helpers are: root_path and root_url
  root "welcome#index"

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
