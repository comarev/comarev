Rails.application.routes.draw do
  devise_for :users, skip: [:sessions]
  as :user do
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
  end
end
