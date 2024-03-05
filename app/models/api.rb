# frozen_string_literal: true

require 'rails/generators'

class Api < ApplicationRecord
  has_many :api_routes, dependent: :destroy

  def self.refresh!
    Rails::Generators.invoke('api_controller')
  end

  def self.call(mapper, _options = {})
    Api.find_each do |api|
      api.api_routes.each do |route|
        mapper.resources route.reference_name.to_sym, only: route.actions
      end
    end
  end
end
