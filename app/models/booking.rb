class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :seat
  belongs_to :show

  validates :user_id, :seat_id, :show_id, presence: true
  validate :seat_must_be_available

  private

  def seat_must_be_available
    if seat.status == "booked"
      errors.add(:seat, "is already booked")
    end
  end
end
