class BookingsController < ApplicationController
  before_action :find_booking, only: [:show]
  def index
    @bookings = Booking.where(user: current_user)
  end

  # def create
  #   @booking = Booking.new(booking_params)
  #   @booking.user = current_user
  #   if @booking.save!
  #     flash[:alert] = 'Congratulations! Your booking has been confirmed.'
  #     redirect_to booking_path(@booking)
  #   else
  #     render :new
  #   end
  # end

  def create
    landmark = Landmark.find(params[:landmark_id])
    booking  = Booking.new(booking_params)
    booking.amount = landmark.price
    booking.state = 'pending'
    booking.user = current_user
    booking.save!

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: landmark.name,
        # images: [landmark.photo_url],
        amount: landmark.price_cents,
        currency: 'gbp',
        quantity: (booking.end_date - booking.start_date).to_i + 1
      }],
      success_url: booking_url(booking),
      cancel_url: booking_url(booking)
    )

    booking.update(checkout_session_id: session.id)
    redirect_to new_booking_payment_path(booking)
  end

  def show
    @review = Review.new
  end

  private

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price, :special_request)
          .merge(params.permit(:landmark_id))
  end
end
