# frozen_string_literal: true

FactoryBot.define do
  factory :expense do
    association :category
    association :user
    amount {Faker::Number.decimal}
    description {Faker::Lorem.word}
  end
end
