# frozen_string_literal: true

class Api < ApplicationRecord
  has_many :api_routes, dependent: :destroy
end
