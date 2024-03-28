# frozen_string_literal: true

class ApiItem < ApplicationRecord
  belongs_to :api_route
  has_one :api, through: :api_route

  before_validation :assign_attributes

  def assign_attributes
    return unless data.is_a?(Hash)
    debugger

    data.each_pair do |attr, value|
      instance_eval { class << self; self end }.send(:attr_accessor, attr)
      instance_variable_set("@#{attr}", value)
    end
  end
end
