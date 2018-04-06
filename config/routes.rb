Rails.application.routes.draw do
  resources :feeds
  get 'search' => 'feeds#search', :as => 'search'

  get 'feeds_all/:type' => 'feeds#index', :as => 'feeds_all'
  post 'delayed_fetch' => 'feeds#delayed_fetch', :as => 'delayed_fetch'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'feeds#index'
end
