class BookingsController < ApplicationController
  before_action :find_booking, only: %i[show destroy accept_booking]

  def index
    @bookings = Booking.where(user: current_user).order(created_at: :desc)
    @my_rentals = Booking.joins(:landmark).where("landmarks.user_id = ?", current_user.id).order(created_at: :desc)

  end

  # def create
  #   if @booking.save!
  #     flash[:alert] = 'Congratulations! Your booking has been confirmed.'
  #     redirect_to booking_path(@booking)
  #   else
  #     render :new
  #   end
  # end

  def create
    landmark = Landmark.find(params[:landmark_id])
    @booking = Booking.new(booking_params)
    @booking.amount = landmark.price
    @booking.state = 'pending'
    @booking.user = current_user
    @booking.save!

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: landmark.name,
        # images: [cl_image_path(landmark.photo.key)],
        amount: landmark.price_cents,
        currency: 'gbp',
        quantity: (@booking.end_date - @booking.start_date).to_i + 1
      }],
      success_url: booking_url(@booking),
      cancel_url: booking_url(@booking)
    )

    @booking.update(checkout_session_id: session.id)
    redirect_to new_booking_payment_path(@booking)
  end

  def show
    @review = Review.new
    @markers = [{ lat: @booking.landmark.latitude, lng: @booking.landmark.longitude, map_popup: render_to_string(partial: "map_popup", locals: { landmark: @booking.landmark }) }]
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end

  def accept_booking
    @booking.state = 'accepted'
    @booking.save!
    redirect_to bookings_path
  end

  def decline_booking
    @booking.state = 'declined'
    @booking.save!
    redirect_to bookings_path
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
