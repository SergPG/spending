# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExpenseDecorator do
  describe '#amount_money_format' do
    subject { expense.decorate.amount_money_format }

    let(:expense) { create :expense, amount: }
    let(:amount) { 10 }

    it { is_expected.to eq('10.00') }
  end

  describe '#small_description' do
    subject { expense.decorate.small_description }

    let(:expense) { create :expense, description: }
    let(:description) { 'small description' }

    it { is_expected.to eq(description) }

    context 'when description is long' do
      let(:description) { 'longlonglonglonglong description' }

      it { is_expected.to eq('longlonglonglonglong...') }
    end
  end
end
