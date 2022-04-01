Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations], controllers: { passwords: 'passwords' }

  as :user do
    post 'signup', to: 'registrations#create'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
  end

  resources :users
  resources :invoices, except: :destroy

  resources :companies do
    resources :discount_requests, only: :index
  end

  get 'showcase', to: 'companies#showcase'
  post 'check_invoices', to: 'invoices#check'
end
