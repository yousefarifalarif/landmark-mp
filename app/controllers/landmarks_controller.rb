class LandmarksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @landmarks = Landmark.all
  end

  def new
    @landmark = Landmark.new
  end

  def create
    @landmark = Landmark.new(landmark_params)
    if @landmark.save
      redirect_to landmarks_path
    else
      render :new
    end
  end

  private

  def landmark_params
    params.require(:landmark).permit(:name, :location, :description, :price_per_day)
  end
end
