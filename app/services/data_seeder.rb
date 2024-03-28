# frozen_string_literal: true

class DataSeeder
  API_UUID = 'fbc73e7e-cf3c-4eaa-bf15-84fbcb99aa85'
  PET_UUID = 'db0b355f-35ab-461b-9b7c-5cafba5cd87f'

  def self.seed_data!
    api = Api.find_or_create_by uuid: API_UUID
    pets = api.api_routes.find_or_initialize_by reference_name: 'pets'
    pets.save!

    pet1 = pets.api_items.find_or_create_by uuid: PET_UUID
    pet1.data = { name: 'rex' }
    pet1.save!

    books = api.api_routes.find_or_create_by reference_name: 'books'
    books.actions = %w[index show]
    books.save!

    Rails.application.reload_routes!
  end
end
