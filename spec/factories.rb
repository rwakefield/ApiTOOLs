# frozen_string_literal: true

FactoryBot.define do
  factory :api_route do
    api
  end

  factory :api do
  end
end

def api_with_api_routes(count: 5)
  FactoryBot.create(:api) do |api|
    FactoryBot.create_list(:api_route, count, api: api)
  end
end
