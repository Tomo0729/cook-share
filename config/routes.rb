Rails.application.routes.draw do
root to: 'public/homes#top'
# 顧客用
# URL /users/sign_in ...
devise_for :user, controllers: {
  registrations: "public/registrations",
  sessions: "public/sessions",
  passwords: "public/passwords"
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, controllers: {
  registrations: "admin/registrations",
  sessions: "admin/sessions"
}

devise_scope :user do
  post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
end

namespace :admin do
    root 'homes#top'
    get '/users/:id/quit' => 'users#quit', as: 'quit_user'
    patch 'users/out' => 'users#out', as: 'out_user'
    resources :users, only: [:show, :index, :edit, :update, :destroy]
    resources :recipes, except: [:destroy]
    resources :comments, only: [:index, :destroy]
  end

 namespace :public do
    root 'homes#top'
    #post "users/guest_sign_in", to: "sessions#guest_sign_in"
    post 'orders/confirm' => 'orders#confirm'
    get '/users/:id/quit' => 'users#quit', as: 'quit_user'
    patch 'users/out' => 'users#out', as: 'out_user'
    get 'search' => 'recipes#search'
    get "tag_search"=>"recipes#tag_search"
    get 'recipes/tag/:tag_name', to: "recipes#tag_search"
    resources :tags
    resources :recipes do
     resources :comments, only: [:create, :destroy]
     resource :favorites, only: [:create, :destroy]
     collection do
       get 'search'
     end
    end
    resources :users, only: [:show, :index, :edit, :update] do
     member do
       get :favorites
     end
    end






  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
