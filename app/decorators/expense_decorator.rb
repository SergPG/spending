class ExpenseDecorator < Draper::Decorator
    delegate_all

    def amount_money_format
        "#{amount} $"
    end
end