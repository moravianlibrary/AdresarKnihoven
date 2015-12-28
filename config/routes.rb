Rails.application.routes.draw do

  match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]
  match "/500" => "errors#error500", via: [ :get, :post, :patch, :delete ]

  get '/libraries/autocomplete', to: 'libraries#autocomplete'  

  resources :libraries, only: [:index, :show]

  resources :events

  resources :projects, only: [:index]

  root  'static_pages#home'
  get   'o-portalu'      => 'static_pages#about'
  get   'zapojene-knihovny'      => 'static_pages#founders'

  get '/feeder/sigla/:sigla', to: 'feeder#sigla'
  get '/feeder/sysno/:sysno', to: 'feeder#sysno'
  get '/feeder/show/:sigla', to: 'feeder#show'

end


