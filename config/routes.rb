Rails.application.routes.draw do
  root to: 'pages#home'
  get :plans, to: "pages#plans"
  get :plans, to: "pages#plans"
  post :plans, to: "pages#create_subscription"
end
