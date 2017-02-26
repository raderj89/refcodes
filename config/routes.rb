Refcodes::Application.routes.draw do
  devise_for :admins

  resources :referrals do
    resources :claims, only: [:create], controller: 'referrals/claims'
  end

  get '/about', to: 'pages#about', as: :about

  root to: 'referrals#index'
end
