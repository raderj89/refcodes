Refcodes::Application.routes.draw do
  resources :referrals
  resources :companies
  
  root to: 'referrals#index'
end
