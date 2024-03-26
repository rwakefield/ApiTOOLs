# frozen_string_literal: true

require 'rails_helper'
require 'with_restful'

class TestPetsController < ApplicationController
end

class TestBooksController < ApplicationController
end

RSpec.describe Api do
  include_context 'with restful'

  let!(:api) { create :api }
  let(:api_uuid) { api.uuid }

  before do
    create :api_route, reference_name: 'test_pet', api: api
    create :api_route, reference_name: 'test_book', api: api, actions: %w[index show]
    Rails.application.reload_routes!
  end

  describe 'routes for Api', type: :routing do
    it 'loads expected routes' do
      expected = %w[
        api_test_pets
        new_api_test_pet
        edit_api_test_pet
        api_test_pet
        api_test_books
        api_test_book
        api_index
        new_api
        edit_api
      ]
      expect(Rails.application.routes.routes.map(&:name).compact).to include(*expected)
    end

    specify do
      expect(get("/api/#{api_uuid}/test_pets/")).to route_to('test_pets#index', api_uuid: api_uuid)
    end

    specify do
      expect(post("/api/#{api_uuid}/test_pets/")).to route_to('test_pets#create', api_uuid: api_uuid)
    end

    specify do
      expect(get("/api/#{api_uuid}/test_pets/new")).to route_to('test_pets#new', api_uuid: api_uuid)
    end

    specify do
      expect(get("/api/#{api_uuid}/test_pets/1/edit")).to route_to('test_pets#edit', api_uuid: api_uuid, id: '1')
    end

    specify do
      expect(get("/api/#{api_uuid}/test_pets/1")).to route_to('test_pets#show', api_uuid: api_uuid, id: '1')
    end

    specify do
      expect(patch("/api/#{api_uuid}/test_pets/1")).to route_to('test_pets#update', api_uuid: api_uuid, id: '1')
    end

    specify do
      expect(put("/api/#{api_uuid}/test_pets/1")).to route_to('test_pets#update', api_uuid: api_uuid, id: '1')
    end

    specify do
      expect(delete("/api/#{api_uuid}/test_pets/1")).to route_to('test_pets#destroy', api_uuid: api_uuid, id: '1')
    end

    specify do
      expect(get("/api/#{api_uuid}/test_books/")).to route_to('test_books#index', api_uuid: api_uuid)
    end

    specify do
      expect(get("/api/#{api_uuid}/test_books/1")).to route_to('test_books#show', api_uuid: api_uuid, id: '1')
    end
  end

  describe 'relationships' do
    it 'has_many api_routes' do
      expect(api.api_routes.pluck(:reference_name)).to contain_exactly('test_pets', 'test_books')
    end

    it 'dependent destroys api_routes' do
      expect do
        api.destroy!
      end.to change { ApiRoute.count }.by(-2)
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

  describe '#route_data' do
    it 'lists all the available route_data configured by the api' do
      expect(JSON.parse(api.route_data)).to eq(
        {
          'GET test_pets#index' => {
            'controller' => 'test_pets',
            'action' => 'index',
            'api_uuid' => api_uuid,
            'path' => '/api/:api_uuid/test_pets',
            'name' => nil,
            'method' => 'get'
          },
          'GET test_pets#new' => {
            'controller' => 'test_pets',
            'action' => 'new',
            'api_uuid' => api_uuid,
            'path' => '/api/:api_uuid/test_pets/new',
            'name' => 'new_api_test_pet',
            'method' => 'get'
          },
          'GET test_pets#edit' => {
            'controller' => 'test_pets',
            'action' => 'edit',
            'api_uuid' => api_uuid,
            'path' => '/api/:api_uuid/test_pets/:id/edit',
            'name' => 'edit_api_test_pet',
            'method' => 'get'
          },
          'GET test_pets#show' => {
            'controller' => 'test_pets',
            'action' => 'show',
            'api_uuid' => api_uuid,
            'path' => '/api/:api_uuid/test_pets/:id',
            'name' => nil,
            'method' => 'get'
          },
          'GET test_books#index' => {
            'controller' => 'test_books',
            'action' => 'index',
            'api_uuid' => api_uuid,
            'path' => '/api/:api_uuid/test_books',
            'name' => 'api_test_books',
            'method' => 'get'
          },
          'GET test_books#show' => {
            'controller' => 'test_books',
            'action' => 'show',
            'api_uuid' => api_uuid,
            'path' => '/api/:api_uuid/test_books/:id',
            'name' => 'api_test_book',
            'method' => 'get'
          }
        }
      )
    end

    describe '.initialize!' do
      before do
        allow(Rails::Generators).to receive(:invoke)
      end

      it 'runs the controller generators' do
        described_class.initialize!
        expect(Rails::Generators).to have_received(:invoke).once.with('api_controller')
      end

      it 'runs the spec generators' do
        described_class.initialize!
        expect(Rails::Generators).to have_received(:invoke).once.with('swagger_spec')
      end
    end
  end
end
