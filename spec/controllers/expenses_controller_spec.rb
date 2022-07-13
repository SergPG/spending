# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'POST #create' do
    let!(:user) { create :user }
    let!(:category) { create :category }
    let(:amount_rand) do
      amount_rand = Random.new
      amount_rand.rand(1.00..100.00)
    end
    let(:params) do
      {
        expense: {
          category_id: category.id,
          amount: amount_rand
        }
      }
    end

    before do
      sign_in(user)
      allow(controller).to receive_messages(current_user: user)
    end

    it 'saves the new expense in the database' do
      expect { post :create, params: }.to change(Expense, :count).by(1)
    end
  end
end
