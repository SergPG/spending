# frozen_string_literal: true

class ExpenseDecorator < Draper::Decorator
  delegate_all

  def amount_money_format
    format('%.2f', amount)
  end

  def updated_at_format
    updated_at.strftime('%d-%m-%Y')
  end

  def small_description
    description.size > 20 ? "#{description[0...20]}..." : description
  end
end
