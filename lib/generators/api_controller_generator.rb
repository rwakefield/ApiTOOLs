# frozen_string_literal: true

require 'rails/generators'

class ApiControllerGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  attr_reader :api_route

  def create_controller_files
    Api.find_each do |api|
      api.api_routes.find_each do |api_route|
        @api_route = api_route
        template 'api_controller.rb', "app/controllers/#{api_route.reference_name}_controller.rb"
      end
    end
  end
end
