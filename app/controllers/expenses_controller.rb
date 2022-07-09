class ExpensesController < ApplicationController
  def index
    @categories = Category.all 
    # binding.pry
  end
end
