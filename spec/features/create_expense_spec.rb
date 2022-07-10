require 'rails_helper'

RSpec.feature 'Expense create', type: :feature do
    include Warden::Test::Helpers

    let!(:user) { create :user }
    let!(:category) {create(:category, name: 'Shops') }
    let(:amount) {'185.05'}
    let(:description) {"It is my expenses in the store Brocard"}
    
    before { login_as(user) }

    scenario 'create new expense' do
        visit new_expense_path()
        expect(page).to have_text("New Expense")
        
        select(category.name, from:'expense_category_id')
        fill_in 'expense_amount' , with: amount
        fill_in 'expense_description' , with: description
        click_button 'Create Expense'

        expect(page).to have_text("#{category.name} expenses")
        expect(page).to have_text("#{amount}")
        expect(page).to have_text("#{description}")

    #  save_and_open_page  
    end
end
