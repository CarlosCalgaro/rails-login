# frozen_string_literal: true

module Authentication
  class LoginService  

    def initialize(user, password)
      @user = user
      @password = password
    end

    def call()
      return error_response(failed_login_message) if !@user
      if @user.authenticate(@password) && !@user.locked
        succesfull_callback
        return success_response
      elsif @user.locked?
        return error_response(account_locked_message)
      else
        error_callback
        return error_response(failed_login_message)
      end
    end

    private
    def account_locked_message
      @account_locked_message ||= ::I18n.t("errors.models.user.attributes.locked")
    end 
    
    def failed_login_message
      @failed_login_message ||= ::I18n.t("alerts.failed_login")
    end
    
    def succesfull_callback
      @user.update(login_attempts: 0)
    end

    def error_callback
      @user.login_attempts += 1
      @user.locked = true if @user.login_attempts == 3
      @user.save
    end
    
    def success_response
      OpenStruct.new({success?: true, user: @user})
    end
    
    def error_response(message = "")
      OpenStruct.new({success?: false, user: @user, message: message})
    end

  end
end
