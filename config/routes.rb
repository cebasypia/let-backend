Rails.application.routes.draw do
  # APIコントローラへのルーティング
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:show]
      resource :users, only: [:update, :destroy]
      get '/tweets', controller: 'tweets', action: 'search'
      get '/tweets/:id', controller: 'tweets', action: 'show'
    end
  end
end
