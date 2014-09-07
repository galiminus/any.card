Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :ideas, only: [:index, :new, :create, :edit, :update, :destroy]
  root to: "ideas#index"
end
