# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiSerializer, type: :serializer do
  def expected_data_for(api:)
    {
      id: api.uuid,
      type: :api
    }
  end

  describe '#serializable_hash' do
    it 'has correct format' do
      api = create :api

      result = described_class.new(api).serializable_hash

      expected = { data: expected_data_for(api: api) }

      expect(result).to eq(expected)
    end
  end
end
