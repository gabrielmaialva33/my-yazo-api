# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resource :users
    get '/users/:id', to: 'users#show'
  end
end
