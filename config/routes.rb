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
    #  Full CRUD for shows (no `only:` restriction)
    resources :shows do
      resources :seats, only: [ :index ] do
        patch :book, on: :member   # seat booking
      end
    end
  end

  # Theatres → Shows
  resources :theatres do
    resources :shows
  end

  # Direct Shows access (not nested under movies)
  resources :shows do
    resources :seats, only: [ :index ] do
      patch :book, on: :member
    end
  end

  #  Global Bookings (user-specific list & cancel)
  resources :bookings, only: [ :index, :show, :destroy ]
  get "/my_bookings", to: "bookings#index", as: "my_bookings"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
