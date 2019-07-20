Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    resources :groups, shallow: true do
      resources :memberships, only: [:create, :destroy]
    end
    resources :messages, shallow: true do
      resources :attachments
      resources :likes, only: [:create, :update,:destroy]
      resources :polls, only: [:create, :update, :destroy] do
        resources :choices, only: [:create, :update, :destroy] do
          resources :answers, only: [:create]
        end
      end
      collection do
        get 'search'
      end
    end
    resources :users, shallow: true do
      resources :avatars, only: [:index, :update, :destroy]
      resources :contacts
      collection do 
        get 'search'
      end
    end
    resources :tokens, only: [:create]
  end
  #match "*path", to: redirect('/api-docs'), via: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
