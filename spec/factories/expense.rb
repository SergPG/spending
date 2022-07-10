FactoryBot.define do
    factory :expense do
      association :category
      association :user
    end
  end
  