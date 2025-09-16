class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :seat
  belongs_to :show

  validates :user_id, :seat_id, :show_id, presence: true
  validate :seat_must_be_available

  after_create :mark_seat_as_booked

  private

  def seat_must_be_available
    if seat.status == "booked"
      errors.add(:seat, "is already booked")
    end
  end

  def mark_seat_as_booked
    seat.update(status: "booked")
  end
end
