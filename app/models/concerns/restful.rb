# frozen_string_literal: true

module Restful
  extend ActiveSupport::Concern

  ACTIONS = %w[index show new edit create update destroy].freeze

  included do
    def http_method_for(action)
      case action
      when 'create'
        'put'
      when 'update'
        'patch'
      when 'destroy'
        'delete'
      else
        ACTIONS.include?(action) ? 'get' : nil
      end
    end
  end
end
