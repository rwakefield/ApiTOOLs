# frozen_string_literal: true

class DataSeeder
  API_UUID = 'fbc73e7e-cf3c-4eaa-bf15-84fbcb99aa85'
  PETS_SCHEMA = {
    type: :object,
    properties: {
      name: { type: :string }
    },
    required: %w[name]
  }.freeze
  BOOKS_SCHEMA = {
    type: :object,
    properties: {
      title: { type: :string },
      author: { type: :string }
    },
    required: %w[title author]
  }.freeze
  CARS_SCHEMA = {
    type: :object,
    properties: {
      make: { type: :string },
      model: { type: :string },
      year: { type: :string }
    },
    required: %w[make model year]
  }.freeze

  def self.seed_data!
    api = Api.find_or_create_by uuid: API_UUID

    pets = api.api_routes.find_or_initialize_by reference_name: 'pets'
    pets.schema = PETS_SCHEMA
    pets.save!

    books = api.api_routes.find_or_create_by reference_name: 'books'
    books.schema = BOOKS_SCHEMA
    books.actions = %w[index show create]
    books.save!

    cars = api.api_routes.find_or_create_by reference_name: 'cars'
    cars.schema = CARS_SCHEMA
    cars.actions = %w[index show create]
    cars.save!

    Rails.application.reload_routes!
  end
end
