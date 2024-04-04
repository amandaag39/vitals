Rails.application.routes.draw do
  devise_for :users

  # OpenAI custom route
  post 'analyze_user_data', to: 'open_ai_chats#analyze_user_data'
  get 'analyze', to: 'open_ai_chats#new'

  # Define the chart route above the resources declaration
  get 'vitals/chart/:vital_id', to: 'vitals#chart', as: :vital_chart

  resources :vitals
  resources :readings

  # Defines the root path route ("/")
  root "welcome#index"

  mount ActiveStorage::Engine => '/active_storage'
end
