class ApiItemSerializer
  attr_reader :api_item

  delegate :api_route,
           :data,
           :uuid, to: :api_item
  delegate :reference_name, to: :api_route

  def initialize(api_item:)
    @api_item = api_item
  end

  def serializable_hash
    {
      type: reference_name,
      id: uuid,
      attributes: data,
      relationships: relationship_data
    }
  end

  private

  def relationship_data
    {
      api_route: {
        data: {
          id: api_route.uuid,
          type: 'api_routes'
        }
      }
    }
  end
end
