Rails.application.routes.draw do
  get 'sessions/new'
  post 'sessions/create'
  patch 'sessions/update'
  delete 'sessions/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'pages#index'
end
