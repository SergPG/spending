class HomeController < ApplicationController
  def index
    @categories = Category.all
    @expenses_shared = Expense.shared
                              .order(updated_at: :desc)
                              .limit(20)
                              .group_by { |e| e.category }
                              .inject({}) { |res, (k, v)| res.merge!(k => v.group_by {|e| e.user }) }

  # binding.pry

  end
end
