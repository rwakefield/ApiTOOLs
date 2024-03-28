# frozen_string_literal: true

class ApiItem < ApplicationRecord
  belongs_to :api_route
  has_one :api, through: :api_route

  def serialized_data
    {
      type: api_route.reference_name,
      id: uuid,
      attributes: data,
      relationships: {
        api_route: {
          data: {
            id: api_route.uuid, type: 'api_routes'
          }
        }
      }
    }
  end
end
