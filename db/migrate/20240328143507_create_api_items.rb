# frozen_string_literal: true

class CreateApiItems < ActiveRecord::Migration[7.1]
  enable_extension 'pgcrypto'

  def change
    create_table :api_items do |t|
      t.uuid :uuid, null: false, default: 'gen_random_uuid()'
      t.jsonb :data, null: false, default: '{}'

      t.timestamps
    end
    add_index :api_items, :data, using: :gin
    add_reference :api_items, :api_route, index: true
  end
end
