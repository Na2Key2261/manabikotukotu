Rails.application.routes.draw do
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    get 'search' => 'homes#search', as: 'search'
    get 'top' => 'homes#top', as: 'admin_top'
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
    passwords: 'public/passwords' # Add passwords controller
  }

  # devise_scope :user do
  #   delete 'users/sign_out', to: 'public/sessions#destroy', as: :logout_user_session
  # end

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
  scope module: :public do
    root 'homes#top'
    get 'users/mypage' => 'users#show', as: 'mypage'
  end

  namespace :public do
    get 'registrations/new' => 'registrations#new', as: 'new_user_registration'
    get '/search', to: 'searches#search', as: 'search'
    resources :users, only: [:show, :edit, :update, :index] do
      resources :posts, only: [:new, :create, :edit, :update] # ネスト
    end
    resources :posts, only: [:new, :create, :edit, :update, :index, :show, :destroy] do
      resource :favorites, only: [:create, :destroy]

      resources :post_comments, only: [:create, :destroy]
  end
  get 'favorites/index', to: 'favorites#index'
  end
end
