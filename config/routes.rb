Rails.application.routes.draw do
  devise_for :users
  root "blogs#index"
  resources :blogs
  get 'healthcheck', to: 'healthcheck#index' # 追記
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
