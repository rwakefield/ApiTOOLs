# frozen_string_literal: true

require 'rails_helper'

class TestPetsController < ApplicationController
end

RSpec.describe ApiItemSerializer do
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

  specify do
    api_item = create :api_item, api_route: api_route, data: { name: 'rex' }
    expected = {
      type: api_route.reference_name,
      id: api_item.uuid,
      attributes: api_item.data,
      relationships: {
        api_route: {
          data: {
            id: api_route.uuid,
            type: 'api_routes'
          }
        }
      }
    }
    expect(described_class.new(api_item: api_item).serializable_hash).to eq(expected)
  end
end
