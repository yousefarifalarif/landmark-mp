class LandmarksController < ApplicationController
  before_action :select_landmark, only: [:show]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @landmarks = Landmark.all
  end

  def new
    @landmark = Landmark.new
  end

  def create
    @landmark = Landmark.new(landmark_params)
    @landmark.user = current_user
    if @landmark.save!
      redirect_to landmarks_path
    else
      render :new
    end
  end

  def show
  end

  private

  def landmark_params
    params.require(:landmark).permit(:name, :location, :description, :price_per_day)
  end

  def select_landmark
    @landmark = Landmark.find(params[:id])
  end
end
