Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations', passwords: 'passwords' }

  namespace :api do
    get 'observations', to: 'observations#index'
    get 'users/index'
    get 'users/update'
  end

  root to: 'api/observations#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
