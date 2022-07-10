require 'rails_helper'

RSpec.feature 'Expense create', type: :feature do
    include Warden::Test::Helpers

    let!(:user) { create :user }

    

    scenario 'create new expense' do
        

    end
end
