Rails.application.routes.draw do
  resource :sign_up, only: [:create]
  resource :sign_in, only: [:create]
  resources :posts, only: [:create, :update, :destroy, :index]
  resources :users, only: [:update, :destroy, :index, :show] do
    member do
      get :timeline
    end
  end  
end