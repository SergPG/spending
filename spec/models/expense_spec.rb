require 'rails_helper'

RSpec.describe Expense, type: :model do

    context 'validations' do
        it { is_expected.to validate_presence_of(:amount) }
        it { is_expected.to validate_presence_of(:category_id) }
        
      end


end
