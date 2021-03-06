# frozen_string_literal: true

class AddLoginAttemptsAndToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :login_attempts, :integer, default: 0
  end
end
