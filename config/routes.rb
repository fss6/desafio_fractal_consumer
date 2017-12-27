Rails.application.routes.draw do
  get 'home', to: 'home#index'
  root to: "home#index"

  scope :auth do
    post 'sign_in', to: 'auth#user_session'
    get 'sign_in', to: 'auth#new_user_session'
    get 'sign_out', to: 'auth#destroy_user_session'
  end

  resources :tasks, only: [:index, :show]
  resources :categories, only: [:index]
  resources :projects
end
