Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :projects, except: [:destroy] do
    member do
      put 'close_for_contribution'
      put 'reopen_for_contribution'
      put 'change_owner'
    end

    resources :signatures, only: [:create]
    resources :contributions, only: [:create]
    resources :adoptions, only: [:create, :destroy]
  end

  get 'about' => 'pages#about'

  resources :google_authorizations, only: :new do
    collection do
      get 'claim'
      get 'grant'
    end
  end

  # You can have the root of your site routed with "root"
  root 'projects#index'
end
