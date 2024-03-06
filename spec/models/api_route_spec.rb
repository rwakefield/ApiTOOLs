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

  describe 'validations' do
    it 'must have one action' do
      api_route = build :api_route, actions: nil
      api_route.valid?
      expect(api_route.errors.full_messages).to contain_exactly 'Actions must have at least one action selected'
    end

    it 'must have valid actions' do
      api_route = build :api_route, actions: ['not a valid action']
      api_route.valid?
      expected = 'Actions must be selected from: index, show, new, edit, create, update, destroy'
      expect(api_route.errors.full_messages).to contain_exactly expected
    end

    it 'must have a reference_name' do
      api_route = build :api_route, reference_name: nil
      api_route.valid?
      expect(api_route.errors.full_messages).to contain_exactly "Reference name can't be blank"
    end
  end

  describe '#reference_name' do
    it 'automatically formats' do
      api_route = create :api_route, reference_name: 'Cool Kid'
      expect(api_route.reload.reference_name).to eq('cool-kids')
    end
  end

  describe '#actions' do
    it 'has a default value' do
      api_route = create :api_route
      expect(api_route.actions).to match_array(described_class::ACTIONS)
    end
  end

  describe '#action_data' do
    it 'lists route data by action' do
      DataSeeder.seed_data!
      api_route = described_class.find_by reference_name: 'pets'
      expect(JSON.parse(api_route.action_data)).to eq(
        {
          'index' => {
            'controller' => 'pets',
            'api_uuid' => 'fbc73e7e-cf3c-4eaa-bf15-84fbcb99aa85',
            'path' => '/api/:api_uuid/pets',
            'name' => nil,
            'method' => 'get'
          },
          'new' => {
            'controller' => 'pets',
            'api_uuid' => 'fbc73e7e-cf3c-4eaa-bf15-84fbcb99aa85',
            'path' => '/api/:api_uuid/pets/new',
            'name' => 'new_api_pet',
            'method' => 'get'
          },
          'edit' => {
            'controller' => 'pets',
            'api_uuid' => 'fbc73e7e-cf3c-4eaa-bf15-84fbcb99aa85',
            'path' => '/api/:api_uuid/pets/:id/edit',
            'name' => 'edit_api_pet',
            'method' => 'get'
          },
          'show' => {
            'controller' => 'pets',
            'api_uuid' => 'fbc73e7e-cf3c-4eaa-bf15-84fbcb99aa85',
            'path' => '/api/:api_uuid/pets/:id',
            'name' => nil,
            'method' => 'get'
          }
        }
      )
    end
  end
end
