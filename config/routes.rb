Rails.application.routes.draw do
  devise_for :users

  root "recipes#index"

  resources :recipes do
    resources :ingredients, only: [:create, :update, :destroy]
    resources :steps,       only: [:create, :update, :destroy]
    member do
      post   :save,   to: "saved_recipes#create"
      delete :unsave, to: "saved_recipes#destroy"
    end
  end

  resources :saved_recipes, only: [:index]

  resources :users, only: [:show] do
    resources :follows, only: [:create, :destroy]
  end
end
