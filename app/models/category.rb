# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :expenses
  has_many :users, through: :expenses

  validates_uniqueness_of :name
end
