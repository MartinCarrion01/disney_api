Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show create] do
      end
      resources :characters do
        member do
          put :set_image
          patch :set_image
        end
      end
      resources :auth, only: [] do
        collection do
          post :login
          put :change_password
          patch :change_password
        end
      end
      resources :titles do
        member do
          post :add_character
        end
      end
      resources :genres
    end
  end
end
