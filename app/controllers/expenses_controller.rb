class ExpensesController < ApplicationController
  def index
    # @categories = Category.all #current_user.categories.distinct
    @total_expenses_amount = expenses.sum(:amount)
    respond_to do |format|
      format.html { render :index, locals: { categories: categories, total_expenses_amount: @total_expenses_amount, expenses: expenses } }
      format.js { render :index, locals: { total_expenses_amount: @total_expenses_amount, expenses: expenses } }
    end
  end

  def show
    render :show, locals: { expense: expense }
  end  

  def new
    @expense = Expense.new(params.permit(:category_id))
    render :new, locals: { categories: categories, expense: @expense }
  end

  def create
    @expense = current_user.expenses.new(expense_params)

    if @expense.save
      redirect_to @expense
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    render :new, locals: { categories: categories, expense: expense }
  end

  def update
    if expense.update(expense_params)
      redirect_to expense
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    expense.destroy

    redirect_to expenses_path, status: :see_other
    
  end



  private

  def expense_params
    params.require(:expense).permit(
      :category_id,
      :amount,
      :description,
      :status
    )
  end

  def expense
    @expenses ||= Expense.find(params[:id])
  end

  def expenses
    @expense ||= current_user.expenses
                             .where(filter_params)
                             .order(created_at: :desc)
  end

  def categories
    @categories ||= Category.all
  end

  def filter_params
    f_params = params.permit(:category_id).compact_blank
    if params[:amount]
      f_params.merge!(amount: params[:amount][:min]..) if params[:amount][:min].present?
      f_params.merge!(amount: ..params[:amount][:max]) if params[:amount][:max].present?
    end
    f_params
  end

end
