# frozen_string_literal: true

class ApiRouteSerializer
  include JSONAPI::Serializer
  set_id :uuid

  attributes :reference_name
  attribute :actions
  attribute :schema do |api_route|
    JSON.parse(api_route.schema)
  end
end
