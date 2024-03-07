# frozen_string_literal: true

require 'rails/generators'

module Generators
  class SwaggerSpecGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    attr_reader :api_route, :parsed_action_data, :title, :api_uuid

    def create_controller_files
      Api.find_each do |api|
        @api_uuid = api.uuid
        api.api_routes.find_each do |api_route|
          @api_route = api_route
          @title = "#{api_route.reference_name.upcase} Api"
          action_data = api_route.action_data.gsub(':api_uuid', '{api_uuid}').gsub(':id', '{id}')
          @parsed_action_data = JSON.parse(action_data).deep_symbolize_keys
          template 'swagger_spec_generator.rb', "spec/requests/#{api_route.reference_name}_spec.rb"
        end
      end
    end
  end
end
