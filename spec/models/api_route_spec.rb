# frozen_string_literal: true

require 'rails_helper'
require 'with_restful'

class TestPetsController < ApplicationController
end

class TestBooksController < ApplicationController
end

RSpec.describe ApiRoute do
  include_context 'with restful'

  let!(:api) { create :api }
  let(:api_uuid) { api.uuid }

  before do
    create :api_route, reference_name: 'test_pet', api: api
    create :api_route, reference_name: 'test_book', api: api, actions: %w[index show]
    Rails.application.reload_routes!
  end

  describe 'relationships' do
    it 'belongs_to api' do
      api_route = create :api_route, api: api
      expect(api_route.api).to eq(api)
    end

    it 'has_many api_items' do
      api_route = create :api_route, api: api
      create_list :api_item, 2, api_route: api_route
      expect(api_route.api_items.count).to eq(2)
    end

    it 'dependent destroys api_items' do
      api_route = create :api_route, api: api
      create_list :api_item, 2, api_route: api_route

      expect do
        api_route.destroy!
      end.to change { ApiItem.count }.by(-2)
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
      api_route = described_class.find_by reference_name: 'test_pets'
      expect(JSON.parse(api_route.action_data)).to eq(
        {
          'index' => {
            'controller' => 'test_pets',
            'api_uuid' => api_uuid,
            'path' => '/api/:api_uuid/test_pets',
            'name' => nil,
            'method' => 'get'
          },
          'new' => {
            'controller' => 'test_pets',
            'api_uuid' => api_uuid,
            'path' => '/api/:api_uuid/test_pets/new',
            'name' => 'new_api_test_pet',
            'method' => 'get'
          },
          'edit' => {
            'controller' => 'test_pets',
            'api_uuid' => api_uuid,
            'path' => '/api/:api_uuid/test_pets/:id/edit',
            'name' => 'edit_api_test_pet',
            'method' => 'get'
          },
          'show' => {
            'controller' => 'test_pets',
            'api_uuid' => api_uuid,
            'path' => '/api/:api_uuid/test_pets/:id',
            'name' => nil,
            'method' => 'get'
          }
        }
      )
    end
  end

  describe '#data' do
    it 'seralizes the api_items data' do
      api_route = create :api_route, reference_name: 'test_pet', api: api
      rex = create :api_item, api_route: api_route, data: { name: 'rex' }
      skippy = create :api_item, api_route: api_route, data: { name: 'skippy' }
      expected = {
        'data' => [
          {
            'type' => 'test_pets',
            'id' => rex.uuid,
            'attributes' => {
              'name' => 'rex'
            },
            'relationships' => {
              'api_route' => {
                'data' => {
                  'id' => api_route.uuid, 'type' => 'api_routes'
                }
              }
            }
          },
          {
            'type' => 'test_pets',
            'id' => skippy.uuid,
            'attributes' => {
              'name' => 'skippy'
            },
            'relationships' => {
              'api_route' => {
                'data' => {
                  'id' => api_route.uuid, 'type' => 'api_routes'
                }
              }
            }
          }
        ]
      }
      expect(JSON.parse(api_route.data)).to eq(expected)
    end
  end
end
