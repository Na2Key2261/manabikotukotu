Rails.application.routes.draw do
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }
  


  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    get 'search' => 'homes#search', as: 'search'
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, except: [:destroy]
  end

  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }

  # destroy_user_session という名前のルートを指定せずに、そのまま destroy アクションにマッチさせる
  devise_scope :user do
  delete 'users/sign_out', to: 'public/sessions#destroy', as: :logout_user_session
end
  
  

  scope module: :public do
    root 'homes#top'
    get 'users/mypage' => 'users#show', as: 'mypage'
    resources :users, only: [:show] do
      resources :posts, only: [:new, :create, :edit, :update]  # ネスト
    end
  end
  
  namespace :public do
    get 'registrations/new' => 'registrations#new', as: 'new_user_registration'
    resources :users, only: [:show] do
      resources :posts, only: [:new, :create, :edit, :update]  # ネスト
    end
  end
end
