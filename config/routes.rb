Rails.application.routes.draw do

  get 'voice_report/report'
  resources :elevators
  resources :columns
  resources :batteries
  resources :customers
  resources :addresses
  resources :leads
  resources :quotes
  resources :employees
  get '/maps', to:'maps#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }
  get 'home/index', to: 'home#index' 

  root to: 'home#index'
 
  post 'home/index',to: 'home#index'

  get 'home/residential', to: 'home#residential'
  get 'home/commercial', to: 'home#commercial'


end
