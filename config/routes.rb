Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :reports
  resources :videos

  # Routes for Google authentication
  get 'auth/:provider/callback', to: 'sessions#google_auth'
  get 'auth/failure', to: redirect('/')

  root 'reports#index'
end
