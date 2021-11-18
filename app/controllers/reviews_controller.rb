class ReviewsController < ApplicationController
  before_action :find_review, only: [:destroy]
  def create
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(review_params)
    if @review.save
      redirect_to booking_path(@booking)
    else
      render 'bookings/show'
    end
  end

  def destroy
    @review.destroy
    redirect_to booking_path(@review.booking)
  end

  private

  def find_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment).merge(params.permit(:booking_id))
  end
end
