class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :theatre
  has_many :seats, dependent: :destroy
  has_many :bookings

  # Make sure all required fields are present
  validates :movie_id, :theatre_id, :start_time, :end_time, :ticket_price, presence: true
end
