Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :answers, only: [:create]
  resources :attachments
  resources :avatars, only: [:show, :update, :destroy]
  resources :choices, only: [:create, :destroy]
  resources :contacts
  resources :groups
  resources :likes, only: [:create, :update,:destroy]
  resources :memberships
  resources :messages do
    collection do
      post 'search'
    end
  end
  resources :polls
  resources :users do
    collection do 
      get 'complete'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
