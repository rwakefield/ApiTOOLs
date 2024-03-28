# frozen_string_literal: true

class AddSchemaToApiRoutes < ActiveRecord::Migration[7.1]
  def change
    remove_column :apis, :schema, :jsonb
    add_column :api_routes, :schema, :jsonb, default: '{}', null: false
  end
end
