Rails.application.routes.draw do
  devise_for :users

  # OpenAI custom route
  # You could use `resources :analysis` instead of the two lines below ; can add a `only: [:new, :create]` option to limit the routes
  post "analysis", to: "analysis#create", as: :analysis
  get "analysis/new", to: "analysis#new", as: :new_analysis

  # Define the chart route above the resources declaration
  get "vitals/chart/:id", to: "vitals#show", as: :vital_chart

  resources :vitals
  resources :readings

  # Defines the root path route ("/")
  root "welcome#index"

  #  do you need this?
  mount ActiveStorage::Engine => "/active_storage"
end
