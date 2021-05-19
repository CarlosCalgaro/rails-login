class SessionsController < ApplicationController
  
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      flash[:notice] = "You have logged in sussessfully"
      redirect_to root_url
    elsif user.nil?
      flash.now[:alert] = "User not found!"
      render :new
    else 
      user.update(login_attempts: user.login_attempts + 1)
      flash.now[:alert] = "Invalid username or password!"
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.permit(:user).require(:email)
  end

end
