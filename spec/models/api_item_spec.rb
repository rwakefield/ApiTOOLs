# frozen_string_literal: true

require 'rails_helper'

class TestPetsController < ApplicationController
end

RSpec.describe ApiItem do
  let(:api_route) { create :api_route, reference_name: 'test_pet', api: api }
  let(:api) { create :api }
  let(:api_uuid) { api.uuid }

  before do
    Rails.application.reload_routes!
  end

  describe 'relationships' do
    it 'belongs_to api_route' do
      api_item = create :api_item, api_route: api_route
      expect(api_item.api_route).to eq(api_route)
    end
  end

  describe '#type' do
    it 'matches reference name' do
      api_item = create :api_item, api_route: api_route
      expect(api_item.type).to eq :test_pet
    end
  end
end
