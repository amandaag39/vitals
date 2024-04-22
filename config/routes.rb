Rails.application.routes.draw do
  devise_for :users

  # OpenAI custom route
  post 'analysis', to: 'analysis#create', as: :analysis
  get 'analysis/new', to: 'analysis#new', as: :new_analysis

  # Define the chart route above the resources declaration
  get 'vitals/chart/:id', to: 'vitals#chart', as: :vital_chart

  resources :vitals
  resources :readings

  # Defines the root path route ("/")
  root "welcome#index"

  mount ActiveStorage::Engine => '/active_storage'
end
