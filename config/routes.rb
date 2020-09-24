Rails.application.routes.draw do
  # APIコントローラへのルーティング
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:show]
      resource :users, only: [:update, :destroy]
    end
  end
end
