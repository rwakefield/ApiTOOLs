# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiRouteSerializer, type: :serializer do
  let(:schema) do
    {
      type: :object,
      properties: {
        name: { type: :string }
      },
      required: %w[name]
    }.to_json
  end

  def expected_data_for(api_route:)
    {
      id: api_route.uuid,
      type: :api_route,
      attributes: {
        actions: api_route.actions,
        reference_name: api_route.reference_name,
        schema: JSON.parse(api_route.schema)
      }
    }
  end

  describe '#serializable_hash' do
    it 'has correct format' do
      api_route = create :api_route, schema: schema

      result = described_class.new(api_route).serializable_hash

      expected = { data: expected_data_for(api_route: api_route) }

      expect(result).to eq(expected)
    end
  end
end
