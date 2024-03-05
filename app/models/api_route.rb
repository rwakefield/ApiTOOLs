# frozen_string_literal: true

class ApiRoute < ApplicationRecord
  belongs_to :api, optional: true
end
