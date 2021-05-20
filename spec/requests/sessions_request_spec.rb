# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  
  describe 'GET /new' do
    it 'returns http success' do
      get '/sessions/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'creates a session with valid attributes' do
      create(:user)
      authentication_params = {
        password_confirmation: '1234567',
        password: '1234567',
        username: 'TestUser'
      }
      post '/sessions/create', :params => authentication_params
      expect(response).to have_http_status(:redirect)
    end

    it 'does not create a session with invalid user' do
      authentication_params = {
        password_confirmation: 'invalidPassword',
        password: 'invalidPassword',
        username: 'invalidUser'
      }
      post '/sessions/create', :params => authentication_params
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not create a session with invalid password' do 
      create(:user)
      authentication_params = {
        password_confirmation: 'invalidPassword',
        password: 'invalidPassword',
        username: 'TestUser'
      }
      post '/sessions/create', :params => authentication_params
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not create a session for locked users' do 
      create(:locked_user)
      authentication_params = {
        password_confirmation: '1234567',
        password: '1234567',
        username: 'TestUser'
      }
      post '/sessions/create', :params => authentication_params
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'DELETE /destroy' do
    it 'returns http success' do
      delete '/sessions/destroy'
      expect(response).to have_http_status(:redirect)
    end
  end
end
