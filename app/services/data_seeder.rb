# frozen_string_literal: true

class DataSeeder
  API_UUID = 'fbc73e7e-cf3c-4eaa-bf15-84fbcb99aa85'

  def self.seed_data!
    api = Api.find_or_create_by uuid: API_UUID
    api.api_routes.find_or_create_by reference_name: 'pets'
    api.api_routes.find_or_create_by reference_name: 'books'
    Api.refresh!
    Rails.application.reload_routes!
  end
end
