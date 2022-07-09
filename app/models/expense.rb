class Expense < ApplicationRecord
  belongs_to :category
  belongs_to :user
  
  enum status: %w[hidden shared]
end
