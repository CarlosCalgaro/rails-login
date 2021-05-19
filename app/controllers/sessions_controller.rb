# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  before_action :check_if_already_logged_in, only: :new
  before_action :set_user, only: :create
  
  def new
  end

  def create
    authentication = Authentication::LoginService.new(@user, params[:password]).call()
    @user = authentication.user
    if authentication.success?
      session[:current_user_id] = @user.id
      redirect_to root_path
    else      
      flash[:alert] = authentication.message
      render :new
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to sessions_new_path
  end

  private

  

  def user_params
    params.permit(:user).require(:email)
  end
  
  def set_user
    @user||= User.find_by(username: params[:username])
  end
  
  def check_if_already_logged_in
    if current_user
      flash[:notice] = t('alerts.already_logged_in')
      redirect_to root_url
    end
  end

end
