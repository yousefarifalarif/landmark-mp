class LandmarksController < ApplicationController
  before_action :select_landmark, only: [:show]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if params[:query].present?
      @query = params[:query]
      @landmarks = Landmark.where("name ILIKE ? OR location ILIKE ? ", "%#{@query}%", "%#{@query}%")
    else
      @landmarks = Landmark.all
    end
    @markers = @landmarks.geocoded.map do |landmark|
      {
        lat: landmark.latitude,
        lng: landmark.longitude,
        map_popup: render_to_string(partial: "map_popup", locals: { landmark: landmark })
      }
    end
  end

  def new
    @landmark = Landmark.new
  end

  def create
    @landmark = Landmark.new(landmark_params)
    @landmark.user = current_user
    @landmark.address = "#{@landmark.name}, #{@landmark.location}"
    if @landmark.save!
      redirect_to landmarks_path
    else
      render :new
    end
  end

  def my_landmarks
    @landmarks = Landmark.where(user: current_user)
  end

  def show
    @booking = Booking.new
    @markers = [{ lat: @landmark.latitude, lng: @landmark.longitude, map_popup: render_to_string(partial: "map_popup", locals: { landmark: @landmark }) }]
  end

  private

  def landmark_params
    params.require(:landmark).permit(:name, :location, :description, :price_per_day, :photo)
  end

  def select_landmark
    @landmark = Landmark.find(params[:id])
  end
end
