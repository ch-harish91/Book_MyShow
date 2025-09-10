class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [ :show, :update, :destroy ]
  before_action :authorize_booking, only: [ :show, :update, :destroy ]

  # GET /bookings (my bookings)
  def index
    @bookings = current_user.bookings.includes(show: [ :movie, :theatre ], seat: :show)
  end

  # GET /bookings/:id
  def show
    # @booking is already loaded & authorized
  end

  # POST /bookings
  def create
    seat = Seat.find(booking_params[:seat_id])
    show = Show.find(booking_params[:show_id])

    if seat.available?
      @booking = Booking.create!(
        user: current_user,
        show: show,
        seat: seat,
        seat_number: seat.seat_number,
        total_price: show.ticket_price,
        seats_booked: 1
      )

      seat.update!(status: "booked", user_id: current_user.id)

      redirect_to bookings_path, notice: "Seat #{seat.seat_number} booked successfully!"
    else
      redirect_to movie_show_path(show.movie, show), alert: "Sorry, this seat is already booked."
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to shows_path, alert: e.message
  end

  # PATCH/PUT /bookings/:id
  def update
    if @booking.update(booking_params.except(:user_id))
      redirect_to booking_path(@booking), notice: "Booking updated successfully!"
    else
      redirect_to bookings_path, alert: "Update failed"
    end
  end

  # DELETE /bookings/:id
  def destroy
    if @booking.status != "cancelled"
      # Release seat if attached
      if @booking.seat.present?
        @booking.seat.update(status: "available", user_id: nil)
      end

      # Mark booking as cancelled (soft delete)
      @booking.update(status: "cancelled")
      notice_message = "Booking cancelled and seat released"
    else
      notice_message = "Booking was already cancelled"
    end

    redirect_to bookings_path, notice: notice_message
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to bookings_path, alert: "Booking not found"
  end

  def authorize_booking
    unless @booking.user_id == current_user.id
      redirect_to bookings_path, alert: "Access denied"
    end
  end

  def booking_params
    params.require(:booking).permit(:show_id, :seat_id, :total_price, :seats_booked, :seat_number)
  end
end
