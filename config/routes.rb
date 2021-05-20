# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'sessions/new'
  post 'sessions/create'
  delete 'sessions/destroy'

  root to: 'pages#index'
end
