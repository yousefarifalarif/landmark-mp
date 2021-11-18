class ReviewsController < ApplicationController
  def create
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(review_params)
    if @review.save!
      redirect_to booking_path(@booking)
    else
      render 'bookings/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment).merge(params.permit(:booking_id))
  end
end
