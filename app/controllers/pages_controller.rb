class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :set_landmark, only: [:show, :create]

  def home
    if params[:query].present?
      @query = params[:query]
      @landmarks = Landmark.where("location LIKE ?", "%#{params[:query]}%")
    else
      @landmarks = Landmark.all
    end
    @newest = @landmarks.order(created_at: :desc).first(6)
    @hottest = @landmarks.sort_by { |landmark| landmark.bookings.count }.first(6)
  end

  def show
  end

  private

  def set_landmark
    @landmark = Landmark.find(params[:id])
  end

  def landmark_params
    params.require(:landmark).permit(:name, :location, :description, :price_per_day)
  end
end
