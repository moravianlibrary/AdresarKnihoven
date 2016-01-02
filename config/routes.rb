Rails.application.routes.draw do

  match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]
  match "/500" => "errors#error500", via: [ :get, :post, :patch, :delete ]

  get '/libraries/autocomplete', to: 'libraries#autocomplete'  

  resources :libraries, only: [:index, :show]

  resources :events

  resources :projects, only: [:index]

  root  'static_pages#home'
  
  get 'o-portalu',                   to: 'static_pages#about',      as: 'about'
  get 'zapojene-knihovny',           to: 'static_pages#founders',   as: 'founders'
  get 'sluzby-knihoven',             to: 'static_pages#services',   as: 'services'
  get 'milniky',                     to: 'static_pages#milestones', as: 'milestones'
  get 'akce-pro-ctenare',            to: 'static_pages#readers',    as: 'readers'
  get 'knihovny-zvou-male-ctenare',  to: 'static_pages#children',   as: 'children'

  get '/feeder/sigla/:sigla', to: 'feeder#sigla'
  get '/feeder/sysno/:sysno', to: 'feeder#sysno'
  get '/feeder/show/:sigla', to: 'feeder#show'

end


