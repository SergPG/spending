class Category < ApplicationRecord
    has_many :expenses 

  validates_uniqueness_of :name
end
