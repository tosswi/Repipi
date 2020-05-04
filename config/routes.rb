Rails.application.routes.draw do
  root to: 'recipes#top'


  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
    }

        scope module: :users do
     resources :users, only: [:show, :edit, :update]
  end
        devise_for :admins, controllers: {
          sessions: 'admins/sessions'
        }

  namespace :admins do
    resources :users,only: [:show,:index,:edit,:update]
    resources :allergies,only: [:index,:create,:edit,:update]
    resources :genres,only: [:index,:create,:edit,:update]
    resources :categories,only: [:index,:create,:edit,:destroy,:update]
  end





  resources :notifications,only: [:index,:create,:destroy,:update]
  resources :recipes,only: [:new,:show,:index,:create,:edit,:destroy,:update] ,shallow: true do
    resource :bookmarks,only: [:index,:create,:destroy,:update]
    get :bookmarks, on: :collection
    resource :recipe_reviews,only: [:create,:destroy]
  end
  resources :refrigerators,only: [:new,:index,:create,:edit,:destroy,:update]
  resources :relationships,only: [:index,:create,:edit,:destroy,:update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
