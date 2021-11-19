Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :landmarks, only: %i[index new create show edit update destroy] do
    resources :bookings, only: %i[new create]
  end

  resources :bookings, only: %i[index show edit update destroy] do
    resources :payments, only: :new
    resources :reviews, only: %i[new create]
  end
  resources :reviews, only: [:destroy]
  get 'my_landmarks', to: 'landmarks#my_landmarks', as: :my_landmarks
  get 'bookings/:id/accept', to: 'bookings#accept_booking', as: :accept_booking
  get 'bookings/:id/decline', to: 'bookings#decline_booking', as: :decline_booking
end
