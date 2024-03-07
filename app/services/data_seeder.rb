# frozen_string_literal: true

class DataSeeder
  API_UUID = 'fbc73e7e-cf3c-4eaa-bf15-84fbcb99aa85'

  def self.seed_data!
    api = Api.find_or_create_by uuid: API_UUID
    pets = api.api_routes.find_or_initialize_by reference_name: 'pets'
    pets.save!

    books = api.api_routes.find_or_create_by reference_name: 'books'
    books.actions = %w[index show]
    books.save!
  end
end
