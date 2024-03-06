# frozen_string_literal: true

class SwaggerSpecGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  attr_reader :api_route

  def create_controller_files
    Api.find_each do |api|
      api.api_routes.find_each do |api_route|
        @api_route = api_route
        template 'swagger_spec_generator.rb', "spec/requests/#{api_route.reference_name}_spec.rb"
      end
    end
  end

  def parsed_action_data
    @parsed_action_data ||= JSON.parse(action_data).deep_symbolize_keys
  end

  def title
    "#{api_route.reference_name.upcase} Api"
  end

  private

  def action_data
    api_route.action_data.gsub(':api_uuid', '{api_uuid}').gsub(':id', '{id}')
  end
end
