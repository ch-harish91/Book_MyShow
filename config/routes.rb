Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  # Shortcut for signup
  get "/signup", to: redirect("/users/sign_up")

  # Root page
  root "movies#index"

  # Movies → Shows → Seats (nested flow)
  resources :movies do
    resources :shows, only: [ :index, :show, :new, :create ] do
      resources :seats, only: [ :index ] do
        patch :book, on: :member   # seat booking
      end
    end
  end

  # Theatres → Shows
  resources :theatres do
    resources :shows, only: [ :index, :show, :new, :create ]
  end

  # Direct Shows access (not nested under movies)
  resources :shows, only: [ :index, :show ] do
    resources :seats, only: [ :index ] do
      patch :book, on: :member
    end
  end

  # ✅ Global Bookings (user-specific list & cancel)
  resources :bookings, only: [ :index, :show, :destroy ]
  get "/my_bookings", to: "bookings#index", as: "my_bookings"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
