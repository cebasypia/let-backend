Rails.application.routes.draw do
  # APIコントローラへのルーティング
  namespace :api, { format: 'json' } do
    namespace :v1 do
      get '/users/register', controller: 'users', action: 'create'
      resources :users, only: [:show]
      resource :users, only: [:update, :destroy]
      get '/tweets', controller: 'tweets', action: 'search'
      get '/tweets/users/:screen_name', controller: 'tweets', action: 'user'
      get '/tweets/timeline/:screen_name', controller: 'tweets', action: 'timeline'
      get '/tweets/:id', controller: 'tweets', action: 'show'
    end
  end
end
