# frozen_string_literal: true

class AddLockedToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :locked, :boolean, default: false
  end
end
