# frozen_string_literal: true

class ApiSerializer
  include JSONAPI::Serializer
  set_id :uuid
end
