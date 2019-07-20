Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    resources :groups, shallow: true do
      resources :memberships, only: [:create, :destroy]
    end
    resources :messages, shallow: true do
      resources :polls, only: [:create, :destroy] do
        resources :choices, only: [:create, :destroy] do
          resources :answers, only: [:create]
        end
      end
      resources :likes, only: [:create, :update,:destroy]
      resources :attachments
      collection do
        post 'search'
      end
    end
    resources :users, shallow: true do
      resources :avatars, only: [:index, :update, :destroy]
      resources :contacts
      collection do 
        get 'complete'
      end
    end
  end
  #match "*path", to: "application#catch_404", via: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
