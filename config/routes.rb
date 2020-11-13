# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :posts do
        resources :comments, only: [:create, :destroy]
      end
    end
  end

  # -> auth
  devise_for :users,
             path: '',
             path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup'
             },
             controllers: {
                 sessions: 'sessions',
                 registrations: 'registrations'
             }
  devise_scope :user do
    delete '/signout', to: 'sessions#delete'
    get '/loggeduser', to: 'sessions#logged?'
  end
end
