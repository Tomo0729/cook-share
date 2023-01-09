Rails.application.routes.draw do
root to: 'public/homes#top'
# 顧客用
# URL /users/sign_in ...
devise_for :user, controllers: {
  registrations: "public/registrations",
  passwords: "public/passwords",
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, controllers: {
  sessions: "admin/sessions"
}

devise_scope :user do
  post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
end

namespace :admin do
    root 'homes#top'
    get '/users/:id/quit' => 'users#quit', as: 'quit_user'
    patch 'users/out' => 'users#out', as: 'out_user'
    resources :users, only: [:show, :index, :edit, :update]
    resources :recipes, except: [:destroy]
    resources :comments
  end

 namespace :public do
    root 'homes#top'
    #post "users/guest_sign_in", to: "sessions#guest_sign_in"
    post 'orders/confirm' => 'orders#confirm'
    get '/users/:id/quit' => 'users#quit', as: 'quit_user'
    patch 'users/out' => 'users#out', as: 'out_user'
    get 'search' => 'recipes#search'
    get 'recipes/tag/:tag_name', to: "recipes#tag_search"
    resources :tags, only: [:index, :show, :destroy]
    resources :recipes do
     collection do
       get 'search'
     end
     resources :comments, only: [:create, :destroy]
     resource :favorites, only: [:create, :destroy]
    end
    resources :users, only: [:show, :index, :edit, :update] do
     member do
       get :favorites
     end
    end






  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
