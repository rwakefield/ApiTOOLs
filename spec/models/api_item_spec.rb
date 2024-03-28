# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiItem do
  describe 'relationships' do
    it 'belongs_to api_route' do
      api_route = create :api_route
      api_item = create :api_item, api_route: api_route
      expect(api_item.api_route).to eq(api_route)
    end
  end
end
