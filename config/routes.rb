Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "letter_opener" if Rails.env.development?
  root :to => 'web/boards#show'

  scope module: :web do
    resource :board, only: :show
    resource :session, only: [:new, :create, :destroy]
    resource :developers, only: [:new, :create]
  end

  namespace :admin do
    resources :users
    get 'passwords/reset', to: 'password_resets#show'
    post 'passwords/reset', to: 'password_resets#create'
    get 'passwords/reset/edit', to: 'password_resets#edit'
    post 'passwords/reset/edit', to: 'password_resets#update'
  end

  namespace :api do
    namespace :v1 do
      resources :tasks, only: [:index, :show, :create, :update, :destroy]
      resources :users, only: [:index, :show]
    end
  end
end
