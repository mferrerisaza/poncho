Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'pages#home'
  get :plans, to: "pages#plans"
  get :plans, to: "pages#plans"
  post :plans, to: "pages#create_subscription"
  resources :subscriptions, only: :show
end
