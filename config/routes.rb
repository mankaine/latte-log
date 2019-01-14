require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :reports
  resources :videos

  mount Sidekiq::Web => '/sidekiq'

:wq
:wq
  root 'reports#index'
end
