# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  sequence :login do |_n|
    Faker::Lorem.word
  end

  factory :user do
    login
    password { 'password' }
    password_confirmation { 'password' }
  end
end
