class ExpensesController < ApplicationController
  def index
    @expenses = current_user.expenses.order(id: :asc)
    @categories = current_user.categories.distinct
#  binding.pry 
  end

  def show

  end  

  def new
    @expense = Expense.new(params.permit(:category_id))
    @categories = Category.all

    
  end

  def create
     
    #binding.pry
    @expense = current_user.expenses.new(expense_params)

    if @expense.save
      redirect_to @expense
    else
      render :new, status: :unprocessable_entity
    end
    
    
    #binding.pry
    
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end



  private
      def expense_params
        params.require(:expense).permit(
          :category_id,
          :amount,
          :description
        )
      end




end
