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
    booking  = Booking.create!(landmark: landmark, price: landmark.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: landmark.name,
        # images: [cl_image_tag landmark.photo.key],
        amount: landmark.price_cents,
        currency: 'gbp',
        quantity: 1
      }],
      success_url: booking_url(booking),
      cancel_url: booking_url(booking)
    )

    booking.update(checkout_session_id: session.id)
    redirect_to new_booking_payment_path(booking)
  end

  def show
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
