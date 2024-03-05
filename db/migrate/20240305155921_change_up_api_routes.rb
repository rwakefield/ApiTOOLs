# frozen_string_literal: true

class ChangeUpApiRoutes < ActiveRecord::Migration[7.1]
  def change
    change_table :api_routes, bulk: true do |t|
      t.remove :path, type: :string
      t.remove :reference_id, type: :integer
      t.remove :reference_type, type: :string
      t.string :reference_name, type: :string
      t.string :actions, array: true, default: %w[index show new edit create update destroy]
    end
  end
end
