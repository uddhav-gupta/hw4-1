class PlacesController < ApplicationController
  before_action :require_login, except: [:index]
  
  def index
    @places = Place.where(user_id: session[:user_id])
  end
  
  def show
    @place = Place.find_by(id: params["id"])
    
    if @place.nil? || @place.user_id != session[:user_id]
      redirect_to places_path, notice: "Place not found"
    else
      @entries = @place.entries
    end
  end
  
  def new
    @place = Place.new
  end
  
  def create
    @place = Place.new(place_params)
    @place.user_id = session[:user_id]  # Assign the current user's ID
    
    if @place.save
      redirect_to @place
    else
      render :new
    end
  end
  
  private
  
  def place_params
    params.require(:place).permit(:name)
  end
end