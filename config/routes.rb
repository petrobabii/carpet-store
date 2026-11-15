Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :users, only: [:new, :create]
  root "carpets#index"
  get "carpets/index"
  get "carpets/show"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :carpets, only: [:index, :show]

  resource :cart, only: [:show] do
    post 'add/:carpet_id', to: 'carts#add', as: 'add_to'
    post 'decrease/:carpet_id', to: 'carts#decrease', as: 'decrease_from'
    delete 'remove/:carpet_id', to: 'carts#remove', as: 'remove_from'
  end
end
