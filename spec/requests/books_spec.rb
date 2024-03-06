# frozen_string_literal: true

# NOTE: This file is auto generated

require 'swagger_helper'

describe 'BOOKS Api' do
  path '/api/{api_uuid}/pets' do
    get 'index a pets' do
      tags 'pets'
      consumes 'application/json'
      response '200', 'success' do
        run_test!
      end
    end
  end
  path '/api/{api_uuid}/pets/new' do
    get 'new a pets' do
      tags 'pets'
      consumes 'application/json'
      response '200', 'success' do
        run_test!
      end
    end
  end
  path '/api/{api_uuid}/pets/{id}/edit' do
    get 'edit a pets' do
      tags 'pets'
      consumes 'application/json'
      response '200', 'success' do
        run_test!
      end
    end
  end
  path '/api/{api_uuid}/pets/{id}' do
    get 'show a pets' do
      tags 'pets'
      consumes 'application/json'
      response '200', 'success' do
        run_test!
      end
    end
  end
end
