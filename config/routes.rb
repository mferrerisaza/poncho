Rails.application.routes.draw do
  root to: 'pages#home'
  get :plans, to: "pages#plans"
end
