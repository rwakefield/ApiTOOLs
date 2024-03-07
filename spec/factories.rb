# frozen_string_literal: true

FactoryBot.define do
  factory :api_route do
    api
    reference_name { Faker::Hacker.noun }
  end

  factory :api do
  end
end
