# frozen_string_literal: true

# NOTE: This file is auto generated

require 'swagger_helper'

describe 'PETS Api' do
  let(:api) { create :api }
  let(:api_route) { create :api_route, api: api, reference_name: 'pets', schema: schema }
  let(:schema) do
    {
      type: :object,
      properties: {
        name: { type: :string }
      },
      required: %w[name]
    }
  end
  let!(:api_item) { create :api_item, api_route: api_route, data: { name: 'rex' }.to_json }
  let(:api_uuid) { api.uuid }
  let(:uuid) { api_item.uuid }

  before do
    Rails.application.reload_routes!
  end

  path '/api/{api_uuid}/pets' do
    get 'pets#index' do
      tags 'pets'
      produces 'application/json'
      parameter name: :api_uuid, in: :path, type: :string
      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/{api_uuid}/pets/{uuid}' do
    get 'pets#show' do
      tags 'pets'
      produces 'application/json'
      parameter name: :api_uuid, in: :path, type: :string
      parameter name: :uuid, in: :path, type: :string
      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/{api_uuid}/pets' do
    post 'pets#create' do
      tags 'pets'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :api_uuid, in: :path, type: :string
      parameter name: :pet, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: %w[name]
      }
      response '201', 'created' do
        let(:pet) do
          {
            name: 'Larry'
          }
        end
        run_test!
      end
    end
  end

  path '/api/{api_uuid}/pets/{uuid}' do
    patch 'pets#update' do
      tags 'pets'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :api_uuid, in: :path, type: :string
      parameter name: :uuid, in: :path, type: :string
      parameter name: :pet, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: %w[name]
      }
      response '200', 'success' do
        let(:pet) do
          {
            name: 'barry'
          }
        end
        run_test!
      end
    end
  end

  path '/api/{api_uuid}/pets/{uuid}' do
    delete 'pets#destroy' do
      tags 'pets'
      produces 'application/json'
      parameter name: :api_uuid, in: :path, type: :string
      parameter name: :uuid, in: :path, type: :string
      response '200', 'success' do
        run_test!
      end
    end
  end
end
