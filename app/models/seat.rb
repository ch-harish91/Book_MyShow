class Seat < ApplicationRecord
  belongs_to :show
  belongs_to :user, optional: true
  has_many :bookings, dependent: :nullify

  validates :seat_number, presence: true

  # Define seat statuses as constants
  STATUSES = %w[available booked].freeze

  # Check if the seat is booked
  def booked?
    status == "booked"
  end

  # Check if the seat is available
  def available?
    status == "available" || status.nil?
  end

  # Book a seat for a user
  def book!(user, show)
    with_lock do
      raise "Seat #{seat_number} is already booked!" if booked?

      # Update seat status and associate user
      update!(status: "booked", user: user)

      # Create booking record if not already exists
      bookings.find_or_create_by!(user: user, show: show)
    end
  end
end
