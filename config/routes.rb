Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/superadmin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, skip: [:sessions], controllers: { omniauth_callbacks: 'callbacks' }
  as :user do
    get 'users/sign_in' => redirect('/'), as: :new_user_session
    post 'users/sign_in' => 'devise/sessions#create', as: :user_session
    delete 'users/sign_out' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  get '/robots.txt', to: 'application#robots'
  root 'application#home'
end
