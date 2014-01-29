Refcodes::Application.routes.draw do
  resources :referrals do 
    get '/claim', to: 'claims#create', as: :claim
  end
  
  root to: 'referrals#index'
end
