Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "dashboard", to: "pages#dashboard", as: :dashboard
  get "my_list", to: "pages#my_list", as: :my_list
  post "save_list", to: "pages#save_list", as: :save_list
  delete "destroy_list/:id", to: "pages#destroy_list", as: :destroy_list
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "shopping_list/:id", to: "ingredients#shopping_list", as: :shopping_list
  get "create_list_ingredients/:id", to: "ingredients#create_list_ingredients", as: :create_list_ingredients
    resources :list_ingredients, only: [:update]
  resources :lists, only: [:create,:update]
  resources :recipes, only: [:index, :show]
  get 'recipes_search', to: 'recipes#search_recipes', as: :search_recipes
end
