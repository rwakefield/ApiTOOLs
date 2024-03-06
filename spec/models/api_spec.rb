# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api, type: :model do
  describe 'routes for Api', type: :routing do
    let(:api_uuid) { DataSeeder::API_UUID }

    before do
      DataSeeder.seed_data!
    end

    it 'loads expected routes' do
      expected = %w[
        api_pets
        new_api_pet
        edit_api_pet
        api_pet
        api_books
        api_book
        api_index
        new_api
        edit_api
      ]
      expect(Rails.application.routes.routes.map(&:name).compact).to include(*expected)
    end

    specify do
      expect(get("/api/#{api_uuid}/pets/")).to route_to('pets#index', api_uuid: api_uuid)
    end

    specify do
      expect(post("/api/#{api_uuid}/pets/")).to route_to('pets#create', api_uuid: api_uuid)
    end

    specify do
      expect(get("/api/#{api_uuid}/pets/new")).to route_to('pets#new', api_uuid: api_uuid)
    end

    specify do
      expect(get("/api/#{api_uuid}/pets/1/edit")).to route_to('pets#edit', api_uuid: api_uuid, id: '1')
    end

    specify do
      expect(get("/api/#{api_uuid}/pets/1")).to route_to('pets#show', api_uuid: api_uuid, id: '1')
    end

    specify do
      expect(patch("/api/#{api_uuid}/pets/1")).to route_to('pets#update', api_uuid: api_uuid, id: '1')
    end

    specify do
      expect(put("/api/#{api_uuid}/pets/1")).to route_to('pets#update', api_uuid: api_uuid, id: '1')
    end

    specify do
      expect(delete("/api/#{api_uuid}/pets/1")).to route_to('pets#destroy', api_uuid: api_uuid, id: '1')
    end

    specify do
      expect(get("/api/#{api_uuid}/books/")).to route_to('books#index', api_uuid: api_uuid)
    end

    specify do
      expect(get("/api/#{api_uuid}/books/1")).to route_to('books#show', api_uuid: api_uuid, id: '1')
    end
  end

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

  describe '#route_data' do
    it 'lists all the available route_data configured by the api' do
      DataSeeder.seed_data!
      api = described_class.find_by uuid: DataSeeder::API_UUID
      expect(JSON.parse(api.route_data)).to eq(
        {
          'GET pets#index' => {
            'controller' => 'pets',
            'action' => 'index',
            'api_uuid' => 'fbc73e7e-cf3c-4eaa-bf15-84fbcb99aa85',
            'path' => '/api/:api_uuid/pets',
            'name' => nil,
            'method' => 'get'
          },
          'GET pets#new' => {
            'controller' => 'pets',
            'action' => 'new',
            'api_uuid' => 'fbc73e7e-cf3c-4eaa-bf15-84fbcb99aa85',
            'path' => '/api/:api_uuid/pets/new',
            'name' => 'new_api_pet',
            'method' => 'get'
          },
          'GET pets#edit' => {
            'controller' => 'pets',
            'action' => 'edit',
            'api_uuid' => 'fbc73e7e-cf3c-4eaa-bf15-84fbcb99aa85',
            'path' => '/api/:api_uuid/pets/:id/edit',
            'name' => 'edit_api_pet',
            'method' => 'get'
          },
          'GET pets#show' => {
            'controller' => 'pets',
            'action' => 'show',
            'api_uuid' => 'fbc73e7e-cf3c-4eaa-bf15-84fbcb99aa85',
            'path' => '/api/:api_uuid/pets/:id',
            'name' => nil,
            'method' => 'get'
          },
          'GET books#index' => {
            'controller' => 'books',
            'action' => 'index',
            'api_uuid' => 'fbc73e7e-cf3c-4eaa-bf15-84fbcb99aa85',
            'path' => '/api/:api_uuid/books',
            'name' => 'api_books',
            'method' => 'get'
          },
          'GET books#show' => {
            'controller' => 'books',
            'action' => 'show',
            'api_uuid' => 'fbc73e7e-cf3c-4eaa-bf15-84fbcb99aa85',
            'path' => '/api/:api_uuid/books/:id',
            'name' => 'api_book',
            'method' => 'get'
          }
        }
      )
    end
  end
end
