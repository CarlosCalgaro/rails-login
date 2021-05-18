Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/update'
  get 'sessions/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'pages#index'
end
