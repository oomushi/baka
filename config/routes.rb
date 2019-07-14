Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :answers
  resources :choices
  resources :attachments
  resources :avatars
  resources :contacts
  resources :likes
  resources :polls
  resources :messages
  resources :memberships
  resources :groups
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
