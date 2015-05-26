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

  get 'google/authorize', to: "google_authorizations#authorize", as: "google_authorizations_authorize"
  get 'google/callback', to: "google_authorizations#callback", as: "google_authorizations_callback"

  # You can have the root of your site routed with "root"
  root 'projects#index'
end
