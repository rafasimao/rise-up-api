Rails.application.routes.draw do
  resources :tasks, only: [:index, :show, :create, :update, :destroy]
  resources :areas, only: [:index, :show, :create, :update, :destroy]
  resources :projects, only: [:index, :show, :create, :update, :destroy]
end
