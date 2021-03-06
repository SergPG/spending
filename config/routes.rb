# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  get 'home/index'
  root to: 'home#index'

  resources :expenses do
    get :share, on: :collection
  end
end
