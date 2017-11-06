# frozen_string_literal: true
Rails.application.routes.draw do
  root to: 'rooms#show'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources 'users'

  get 'api/chat_box', to: 'rooms#api'
end
