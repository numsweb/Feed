Rails.application.routes.draw do

  resources :feeds
  get 'search' => 'feeds#search', :as => 'search'
  get 'home' => 'feeds#index', as: 'home'
  get 'feeds_all/:type' => 'feeds#index', :as => 'feeds_all'

  get 'about' => 'home#about', as: 'about'
  get 'contact' => 'home#contact', as: 'contact'

  post 'delayed_fetch' => 'feeds#delayed_fetch', :as => 'delayed_fetch'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'feeds#index'


  #sidekiq
  if FEED_COLLECTION_AGENT == 'sidekiq'
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
    Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
  end

end
