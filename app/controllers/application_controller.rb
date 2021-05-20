# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end

  private

  def authenticate_user!
    if current_user && current_user.locked?
      flash.now[:alert] = t('activerecord.errors.models.user.attributes.locked')
      redirect_to sessions_new_path
    elsif !current_user
      redirect_to sessions_new_path
    end
  end
end
