# frozen_string_literal: true

require 'rails/generators'

class Api < ApplicationRecord
  include Restful

  has_many :api_routes, dependent: :destroy

  def self.initialize!
    Rails::Generators.invoke('api_controller')
    Rails::Generators.invoke('swagger_spec')
  end

  def self.call(mapper, _options = {})
    Api.find_each do |api|
      api.api_routes.each do |route|
        mapper.resources route.reference_name.to_sym, only: route.actions
      end
    end
  end

  def route_data
    @route_data ||= fetch_route_data.to_json
  end

  private

  def fetch_route_data
    route_data = {}
    Rails.application.routes.routes.each do |route|
      path = route.path.spec.to_s.gsub('(.:format)', '')
      next unless path.starts_with?('/api/:api_uuid')

      data = data_for(path, route)

      key = "#{data[:method].upcase} #{data[:controller]}##{data[:action]}"
      route_data[key] = data
    end
    route_data
  end

  def data_for(path, route)
    info = Rails.application.routes.recognize_path(path).except(:id)
    info[:path] = path
    info[:api_uuid] = uuid
    info[:name] = route.name
    info[:method] = http_method_for(info[:action])
    info
  end
end
