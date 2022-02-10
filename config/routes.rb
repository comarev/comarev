Rails.application.routes.draw do
  devise_for :users, skip: [:sessions]

  as :user do
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
  end

  resources :users
  resources :companies
  get 'showcase', to: 'companies#showcase'
  resources :invoices, except: :destroy
  post 'check_invoices', to: 'invoices#check'
end
