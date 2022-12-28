Rails.application.routes.draw do
root to: 'public/homes#top'
# 顧客用
# URL /users/sign_in ...
devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'

}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
    root 'homes#top'
    get '/users/:id/quit' => 'users#quit', as: 'quit_user'
    patch 'users/out' => 'users#out', as: 'out_user'
    resources :users, only: [:show, :index, :edit, :update]
    resources :recipes, except: [:destroy]
    resources :comments, only: [:index, :edit, :update, :destroy]
  end

 namespace :public do
    root 'homes#top'
    post 'orders/confirm' => 'orders#confirm'
    get '/users/:id/quit' => 'users#quit', as: 'quit_user'
    patch 'users/out' => 'users#out', as: 'out_user'
    get 'search' => 'recipes#search'
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
    devise_scope :user do
     post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    end


  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
