class PlacesController < ApplicationController
  before_action :require_login, except: [:index]
  
  def index
    @places = Place.all
  end
  
  def show
    @place = Place.find_by(id: params[:id])
    if @place
      @entries = @current_user.entries.where(place_id: @place.id)
    else
      redirect_to places_path, alert: "Place not found"
    end
  end
  
  def new
    @place = Place.new
  end
  
  def create
    @place = Place.new(place_params)
    if @place.save
      redirect_to places_path, notice: "Place added!"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def place_params
    params.require(:place).permit(:name)
  end
end