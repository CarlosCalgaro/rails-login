# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :password

  validates :username, presence: true, uniqueness: true, length: { in: 6..15 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password, confirmation: true, length: { in: 6..20 }, if: :password_present?
  validates :password_confirmation, presence: true, if: :password_present?

  before_save :set_password_digest

  def authenticate(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def unlock!
    update(login_attempts: 0, locked: false)
  end

  private

  def set_password_digest
    return if password.nil? || password_confirmation.nil?
    self.password_digest = BCrypt::Password.create(password)
  end

  def password_present?
    password.present?
  end
end
