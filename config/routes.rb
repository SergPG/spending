Rails.application.routes.draw do
  devise_for :users

  root to: "expenses#index"

  resources :expenses, only: [:index]
end
