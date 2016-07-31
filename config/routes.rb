Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'offers#index'

  resources :offers, only: [:index, :create]
end
