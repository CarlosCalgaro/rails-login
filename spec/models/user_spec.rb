# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do

  context ".authenticate" do 
    it "returns true only when passwords matches" do 
      password = "C.AffSSeQF12!"
      second_password="1234567890"
      user = create(:user, password: password, password_confirmation: password)
      expect(user.authenticate(password)).to be true
      expect(user.authenticate(second_password)).to be false
    end
  end
  
  describe 'validation tests' do
    context 'on creation' do
      it 'ensures password is present' do
        user = build(:user, password: nil, password_confirmation: nil)
        expect(user).to be_invalid
        expect(user.errors[:password]).to be_present
      end

      it 'ensures password is between 6 and 15 characters' do 
        long_password_user = build(:user, password: '1234567890qwerty12345', 
                                   password_confirmation: '1234567890qwerty12345')
        short_password_user = build(:user, password: '1234', password_confirmation: '1234')
  
        expect(long_password_user).to be_invalid
        expect(long_password_user.errors[:password]).to be_present
        expect(short_password_user).to be_invalid
        expect(short_password_user.errors[:password]).to be_present
      end
  
    end

    context 'on updating' do
      it 'allows updating without password' do
        user = create(:user)
        user.assign_attributes(username: "OtherName", password: nil, password_confirmation: nil)
        expect(user).to be_valid
      end
    end

    context 'when password is present' do 
      
      it 'ensures password_confirmation is present' do 
        user = build(:user, password_confirmation: nil)
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to be_present
      end


      it 'ensures password_confirmation and password to be equal' do 
        user = build(:user, password: '12345678', password_confirmation: '1234567890')
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to be_present
      end
    end
    
    it 'ensures username is present' do
      user = build(:nameless_user)
      expect(user).to be_invalid
      expect(user.errors[:username]).to be_present
    end
    
    it 'ensures username is between 6 and 15 characters' do 
      long_named_user = build(:long_named_user)
      short_named_user = build(:short_named_user)

      expect(long_named_user).to be_invalid
      expect(long_named_user.errors[:username]).to be_present
      expect(short_named_user).to be_invalid
      expect(short_named_user.errors[:username]).to be_present
    end

    it 'ensures username is unique' do 
      create(:user)
      user = build(:user)
      expect(user).to be_invalid
      expect(user.errors[:username]).to be_present
    end
  end

end
