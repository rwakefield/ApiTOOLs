# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiItemSerializer, type: :serializer do
  def expected_data_for(api_item:)
    {
      id: api_item.uuid,
      type: api_item.api_route.reference_name.singularize.to_sym,
      attributes: {
        data: JSON.parse(api_item.data)
      }
    }
  end

  describe '#serializable_hash' do
    it 'has correct format' do
      api_item = create :api_item, data: { name: 'rex' }.to_json

      result = described_class.new(api_item).serializable_hash

      expected = { data: expected_data_for(api_item: api_item) }

      expect(result).to eq(expected)
    end
  end
end
