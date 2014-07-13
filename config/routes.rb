Frequency::Application.routes.draw do

  resources :pictures do
    resources :comments do
      member do
        get :like
        get :unlike
      end
    end
    member do
      get :like
      get :unlike
    end
  end

  resources :blogs, path: 'frequency' do
    member do
      get :like
      get :unlike
    end
  end

  resources :users, :user_sessions

  resources :boards do
    collection do
      get :mark_all_as_read
    end

    resources :conversations do
      resources :posts do
        member do
          get :like
          get :unlike
        end
      end
    end
  end

  root :to => 'overview#index'

  match 'overview' => 'overview#index', as: :overview
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'signup' => 'users#new', :as => :signup
end
