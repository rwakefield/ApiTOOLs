# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api, type: :model do
  describe 'relationships' do
    it 'has_many api_routes' do
      expect do
        api_with_api_routes(count: 3)
      end.to change(ApiRoute, :count).from(0).to(3)
    end
  end

  describe '#uuid' do
    it 'has a default value' do
      api = described_class.new

      api.save!

      expect(api.reload.uuid).not_to be_nil
    end
  end

  describe '#schema' do
    it 'has a default value' do
      api = described_class.new

      api.save!

      expect(api.reload.schema).not_to be_nil
    end
  end
end
