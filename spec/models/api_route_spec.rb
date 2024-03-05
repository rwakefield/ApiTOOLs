# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiRoute, type: :model do
  describe 'relationships' do
    it 'belongs_to api' do
      api = create :api
      api_route = create :api_route, api: api
      expect(api_route.api).to eq(api)
    end
  end
end
