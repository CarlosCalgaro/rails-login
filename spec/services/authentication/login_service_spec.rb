# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LoginService' do

  describe '.call' do 
      context 'on a successfull login' do 
        it 'returns an object with .success? and user attributes' do 
          password = "CaH.,,!ndk"
          user = create(:user, password: password, password_confirmation: password)
          authentication = Authentication::LoginService.new(user, password).call()
          expect(authentication).to respond_to(:success?)
          expect(authentication).to respond_to(:user)
        end

        it 'ensure user login_attempts are reset' do 
          password = "CaH.,,!ndk"
          user = create(:user, login_attempts: 2, password: password, password_confirmation: password)
          authentication = Authentication::LoginService.new(user, password).call()
          expect(user.login_attempts).to be 0
        end
      end

      context 'on an unsuccessfull login attempt' do 
        it 'returns an object with .success?, user and message attributes' do 
          password = "CaH.,,!ndk"
          second_password = '1234567890'
          user = create(:user, password: password, password_confirmation: password)
          authentication = Authentication::LoginService.new(user, second_password).call()
          expect(authentication).to respond_to(:success?)
          expect(authentication).to respond_to(:user)
          expect(authentication).to respond_to(:message)
        end

        it 'ensure user login_attempts are incremented' do 
          password = "CaH.,,!ndk"
          second_password = '1234567890'
          user = create(:user, login_attempts: 0, password: password, password_confirmation: password)
          authentication = Authentication::LoginService.new(user, second_password).call()
          expect(user.login_attempts).to be 1
        end

        it 'ensure user is locked after his 3rd attempt' do 
          password = "CaH.,,!ndk"
          second_password = '1234567890'
          user = create(:user, login_attempts: 2, password: password, password_confirmation: password)
          authentication = Authentication::LoginService.new(user, second_password).call()
          expect(user.login_attempts).to be 3
          expect(user.locked).to be true
        end
      end

      context 'when user is locked' do 
        it "ensures user can't log in" do
          password = "CaH.,,!ndk"
          user = create(:locked_user, password: password, password_confirmation: password)
          authentication = Authentication::LoginService.new(user, password).call()
          user = authentication.user
          expect(authentication.success?).to be false
          #expect(authentication.message).to exists
        end
      end

      context 'when user doesnt exists' do 
        it "ensures user can't log in" do
          password = "CaH.,,!ndk"
          authentication = Authentication::LoginService.new(nil, password).call()
          expect(authentication.success?).to be false
          #expect(authentication.message).to exists
        end
      end

      context 'when password is incorrect doesnt exists' do 
        it "ensures user can't log in" do
          password = "CaH.,,!ndk"
          second_password= "234567890-"
          user = create(:locked_user, password: password, password_confirmation: password)
          authentication = Authentication::LoginService.new(user, second_password).call()
          expect(authentication.success?).to be false
        end
      end
  end
end
