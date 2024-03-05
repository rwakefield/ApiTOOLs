# frozen_string_literal: true

class CreateApis < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto'

    create_table :apis do |t|
      t.uuid :uuid, null: false, default: 'gen_random_uuid()'
      t.jsonb :schema, null: false, default: '{}'
      t.timestamps
    end
    add_index :apis, :schema, using: :gin

    create_table :api_routes do |t|
      t.uuid :uuid, null: false, default: 'gen_random_uuid()'
      t.string :path
      t.string :reference_type
      t.integer :reference_id
      t.timestamps
    end
    add_reference :api_routes, :api, index: true
  end
end
