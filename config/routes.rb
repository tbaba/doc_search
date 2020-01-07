Rails.application.routes.draw do
  root 'documents#index'

  resources :documents, only: [:index, :show, :new, :create]
end
