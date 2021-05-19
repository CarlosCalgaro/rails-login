class ApplicationController < ActionController::Base

    before_filter :authenticate_user!


    def authenticate_user!
       redirect_to sessions_new_path if @current_user.nil?
    end

    private

    def current_user
        @current_user ||= User.find_by(id: session[:current_user_id])
    end

end
