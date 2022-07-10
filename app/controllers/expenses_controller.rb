class ExpensesController < ApplicationController
  def index
    @expenses = current_user.expenses.order(id: :asc)
    @categories = current_user.categories.distinct
#  binding.pry 
  end

  def show
    @expense = Expense.find(params[:id]) 
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
  end

  def edit
    @expense = Expense.find(params[:id]) 
    @categories = Category.all    
  end

  def update
    @expense = Expense.find(params[:id]) 

    if @expense.update(expense_params)
      redirect_to @expense
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    redirect_to expenses_path, status: :see_other
    
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
