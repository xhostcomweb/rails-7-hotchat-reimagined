# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :rooms
  namespace :admin do
    resources :users
    resources :services
    resources :notifications
    resources :announcements

    root to: 'users#index'
  end
  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    # get 'users' => 'devise/sessions#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'user/:id', to: 'users#show', as: 'user'
  root to: 'home#index'
end