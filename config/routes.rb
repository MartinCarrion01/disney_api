Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show create] do
      end
      resources :auth, only: [] do
        collection do
          post :login
          put :change_password
          patch :change_password
        end
      end
    end
  end
end
