Rails.application.routes.draw do
  get 'rooms/show'
  post '/rate' => 'rater#create', :as => 'rate'
  root to: 'recipes#top'


  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'

    }

        scope module: :users do
     resources :users, only: [:show, :edit, :update,:index]
      get :following, :followers
  end
        devise_for :admins, controllers: {
          sessions: 'admins/sessions'
        }

  namespace :admins do
    resources :users,only: [:show,:index,:edit,:update]
    resources :genres,only: [:index,:create,:edit,:update]
    resources :categories,only: [:index,:create,:edit,:destroy,:update]
  end
  resources :notifications,only: :index
  resources :recipes,only: [:new,:show,:index,:create,:edit,:destroy,:update] ,shallow: true do
    resource :bookmarks,only: [:index,:create,:destroy,:update]
    get :bookmarks, on: :collection
    resource :recipe_reviews,only: [:create,:destroy]
  end
  resources :refrigerators,only: [:new,:index,:create,:edit,:destroy,:update]
  resources :rooms,only: [:index,:show,:create,:destroy]
  resources :relationships,only: [:index,:create,:destroy]do
   post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す

end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
