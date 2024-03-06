# frozen_string_literal: true

module Restful
  extend ActiveSupport::Concern

  included do
    def http_method_for(action)
      case action
      when 'create'
        'put'
      when 'update'
        'patch'
      when 'delete'
        'delete'
      else
        'get'
      end
    end
  end
end
