Refcodes::Application.routes.draw do
  resources :referrals

  root to: 'referrals#index'
end
