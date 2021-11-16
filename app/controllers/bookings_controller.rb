class BookingsController < ApplicationController
  before_action :find_booking, only: [:show]
  def index
    @bookings = Booking.where(user: current_user)
  end

  def new
    @landmark = Landmark.find(params[:landmark_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    if @booking.save!
      flash[:alert] = 'Congratulations! Your booking has been confirmed.'
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def show; end

  private

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price, :special_request)
          .merge(params.permit(:landmark_id))
  end
end
