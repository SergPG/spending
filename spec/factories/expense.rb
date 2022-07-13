# frozen_string_literal: true

FactoryBot.define do
  factory :expense do
    association :category
    association :user
  end
end
