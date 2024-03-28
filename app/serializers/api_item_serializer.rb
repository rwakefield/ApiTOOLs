# frozen_string_literal: true

class ApiItemSerializer
  include JSONAPI::Serializer
  set_id do |api_item|
    self.record_type = run_key_transform(api_item.type)
    api_item.uuid
  end

  attribute :data do |api_item|
    JSON.parse(api_item.data)
  end
end
