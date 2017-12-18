Rails.application.routes.draw do

  resources :top_urls, only: [ :index ]
  resources :top_referrers, only: [ :index ]

  root to: 'dashboard#index'
end
