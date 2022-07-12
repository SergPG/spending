class ExpensesController < ApplicationController
  def index
    # @categories = Category.all #current_user.categories.distinct
    total_expenses_amount =  format("%.2f", expenses.sum(:amount))
    respond_to do |format|
      format.html { render :index, locals: { categories: categories, total_expenses_amount: total_expenses_amount, expenses: expenses.decorate } }
      format.js { render :index, locals: { total_expenses_amount: total_expenses_amount, expenses: expenses.decorate } }
    end
  end

  def show
    render :show, locals: { expense: expense }
  end  

  def new
    new_expense = Expense.new(params.permit(:category_id))
    render :new, locals: { categories: categories, expense: new_expense }
  end

  def create
    new_expense = current_user.expenses.new(expense_params)

    if new_expense.save
      redirect_to new_expense
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    render :edit, locals: { categories: categories, expense: expense }
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

  def share
    render :share, locals: { shared_expenses: shared_expenses }
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
    @expenses ||= Expense.find(params[:id]).decorate
  end

  def expenses
    @expense ||= current_user.expenses
                             .where(filter_params)
                             .order(updated_at: :desc)
  end

  def shared_expenses
    @shared_expenses ||= Expense.by_shared_group_user_category(Expense::DEFAULT_LIMIT)
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
