# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataSeeder, type: :service do
  before do
    described_class.seed_data!
  end

  it 'creates an api record' do
    expect(Api.count).to eq 1
  end

  it 'creates api_routes records' do
    expect(ApiRoute.count).to eq 2
  end

  it 'has correct relations' do
    expect(Api.first.api_routes.count).to eq 2
  end

  it 'creates api with expected data' do
    api = Api.find_by uuid: described_class::API_UUID
    expect(api.api_routes.pluck(:reference_name)).to contain_exactly('pets', 'books')
  end

  it 'can be run more than once' do
    expect do
      described_class.seed_data!
    end.to change(Api, :count).by(0).and change(ApiRoute, :count).by(0)
  end
end
