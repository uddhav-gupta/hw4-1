class SessionsController < ApplicationController
  def new
    # displays login form
  end
  
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to places_path, notice: "Welcome!"
    else
      flash[:alert] = "Login failed. Invalid email or password."
      redirect_to login_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "You have been logged out."
  end
end