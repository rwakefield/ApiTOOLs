# frozen_string_literal: true

# NOTE: This file is auto generated

require 'swagger_helper'

describe 'BOOKS Api' do
  let(:api_uuid) { 'fbc73e7e-cf3c-4eaa-bf15-84fbcb99aa85' }
  let(:id) { 1 }

  path '/api/{api_uuid}/books' do
    get 'index a books' do
      tags 'books'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :api_uuid, in: :path, type: :string
      parameter name: :id, in: :path, type: :string
      response '200', 'success' do
        run_test!
      end
    end
  end
  path '/api/{api_uuid}/books/{id}' do
    get 'show a books' do
      tags 'books'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :api_uuid, in: :path, type: :string
      parameter name: :id, in: :path, type: :string
      response '200', 'success' do
        run_test!
      end
    end
  end
end
