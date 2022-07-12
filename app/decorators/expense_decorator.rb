class ExpenseDecorator < Draper::Decorator
    delegate_all

    def amount_money_format
        format("%.2f", amount)
    end
end