Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :users, only: [:new, :create]

  root "carpets#index"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :carpets do
    collection do
      get :manage
    end
    resources :reviews, only: [:create, :destroy]
  end

  resource :cart, only: [:show] do
    post 'add/:carpet_id', to: 'carts#add', as: 'add_to'
    post 'decrease/:carpet_id', to: 'carts#decrease', as: 'decrease_from'
    delete 'remove/:carpet_id', to: 'carts#remove', as: 'remove_from'
  end

  resources :orders, only: [:index, :new, :create, :update] do
    collection do
      get :manage
    end
  end

  resources :feedbacks, only: [:new, :create, :update, :destroy] do
    collection do
      get :manage
    end
  end
end