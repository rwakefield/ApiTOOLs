# frozen_string_literal: true

require 'rails_helper'

class TestPetsController < ApplicationController
end

RSpec.describe ApiItem do
  let(:api_route) { create :api_route, reference_name: 'test_pet', api: api }
  let(:api) { create :api, schema: api_schema }
  let(:api_uuid) { api.uuid }
  let(:api_schema) do
    {
      pets: {
        properties: {
          id: { type: :string },
          name: { type: :string }
        },
        required: %w[id name]
      }
    }
  end

  before do
    Rails.application.reload_routes!
  end

  describe 'relationships' do
    it 'belongs_to api_route' do
      api_item = create :api_item, api_route: api_route
      expect(api_item.api_route).to eq(api_route)
    end
  end

  describe 'data and attributes' do
    it 'has attributes from the api schema and data' do
      api_item = create :api_item, api_route: api_route, data: { name: 'rex' }
      expect(api_item.name).to eq('rex')
    end
  end
end
