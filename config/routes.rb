Rails.application.routes.draw do
  namespace :api do
    get '/users', to: 'users#index'
    get '/users/:id', to: 'users#show'
    post '/users', to: 'users#create'
    put '/users/:id', to: 'users#update'
    delete '/users/:id', to: 'users#delete'
  end
end
