Rails.application.routes.draw do
  root to: 'recipes#top'
  get 'rooms/show'
  post '/rate' => 'rater#create', :as => 'rate'
  delete 'notifications/destroy_all' => 'notifications#destroy_all'
  namespace :users do
    get 'confirm' => 'users#confirm'
    patch 'hide' => 'users#hide'
    put 'hide' => 'users#hide'
    get 'explanation' => 'users#explanation'
end
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registration: 'users/registrations',
      passwords: 'users/passwords',
      omniauth_callbacks: 'users/omniauth_callbacks'
    }
        scope module: :users do
          resources :users, only: [:show, :edit, :update,:index]do
      get :following, :followers
        get 'followindex'
    get 'followerindex'
  end
  end
        devise_for :admins, controllers: {
          sessions: 'admins/sessions'
        }
  namespace :admins do
    get '/' => 'admins#top'
    resources :users,only: [:show,:index,:edit,:update]
    resources :recipes,only: [:show,:destroy] do
    resource :recipe_reviews,only: [:destroy]
    end
    resources :genres,only: [:index,:create,:edit,:update]
    resources :categories,only: [:index,:create,:edit,:destroy,:update]
  end
  resources :notifications,only: [:index,:destroy]
  resources :recipes,only: [:new,:show,:index,:create,:edit,:destroy,:update] ,shallow: true do
    resource :points,only: [:create,:destroy,:update]
    resource :recipe_images,only: [:index,:create,:destroy,:update]
    resource :bookmarks,only: [:index,:create,:destroy,:update]
    get :bookmarks, on: :collection
    resource :recipe_reviews,only: [:create,:destroy,:edit,:update]
  end
  resources :refrigerators,only: [:new,:index,:create,:edit,:destroy,:update]
  resources :rooms,only: [:index,:show,:create,:destroy]
  resources :relationships,only: [:index,:create,:destroy]

post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
delete 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
