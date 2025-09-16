class SeatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_show
  before_action :set_seat, only: [ :book ]

  # GET /shows/:show_id/seats
  def index
    @seats = @show.seats.order(:seat_number)
  end

  # PATCH /shows/:show_id/seats/:id/book
  def book
    if @seat.status == "booked"  # Or use @seat.booked? if you have a method
      flash[:alert] = "Seat #{@seat.seat_number} is already booked!"
    else
      ActiveRecord::Base.transaction do
        Booking.create!(
          user: current_user,
          show: @show,
          seat: @seat
        )

        # ✅ Update seat status instead of `available`
        @seat.update!(status: "booked")
      end

      flash[:notice] = "Seat #{@seat.seat_number} booked successfully!"
    end

    redirect_to show_seats_path(@show)
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    flash[:alert] = "Booking failed: #{e.message}"
    redirect_to show_seats_path(@show)
  end

  private

  def set_show
    @show = Show.find(params[:show_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Show not found."
    redirect_to root_path
  end

  def set_seat
    @seat = @show.seats.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Seat not found."
    redirect_to show_seats_path(@show)
  end
end
