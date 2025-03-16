class EntriesController < ApplicationController
  before_action :require_login
  
  def new
    @place = Place.find_by(id: params[:place_id])
    @entry = Entry.new
  end
  
  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = current_user.id
    
    if @entry.save
      redirect_to place_path(@entry.place), notice: "Entry created successfully!"
    else
      render :new
    end
  end
  
  private
  
  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :place_id, :image)
  end
end