class Authentication::FailedLoginService

    def self.perform(user)
        Authentication::FailedLoginService.new.perform(user)
    end
    
    def perform(user)
        login_attempts = user.login_attempts + 1
        if login_attempts == 3
            user.locked = true
        end
        user.login_attempts = login_attempts
        user.save
        return user
    end
    
end