# frozen_string_literal: true

class ApiItem < ApplicationRecord
  belongs_to :api_route
  has_one :api, through: :api_route

  def type
    api_route.reference_name.singularize.to_sym
  end
end
