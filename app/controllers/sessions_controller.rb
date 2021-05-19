class SessionsController < ApplicationController
  
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && !user.locked && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      flash[:notice] = "You have logged in sussessfully"
      redirect_to root_url
    elsif user.locked?
      flash.now[:alert] = "Account locked. Contact your administrator!"
      render :new
    else
      Authentication::FailedLoginService::perform(user) unless user.nil?
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
