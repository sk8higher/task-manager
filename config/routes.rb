require 'sidekiq_unique_jobs/web'

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "letter_opener" if Rails.env.development?
  mount Sidekiq::Web => '/admin/sidekiq'

  root :to => 'web/boards#show'

  scope module: :web do
    resource :board, only: :show
    resource :session, only: [:new, :create, :destroy]
    resource :developers, only: [:new, :create]
    resource :password_resets, only: [:new, :create, :edit, :update]
  end

  namespace :admin do
    resources :users
  end

  namespace :api do
    namespace :v1 do
      resources :tasks, only: [:index, :show, :create, :update, :destroy]
      put '/attach_image', to: "tasks#attach_image"
      put '/remove_image', to: "tasks#remove_image"
      resources :users, only: [:index, :show]
    end
  end
end
