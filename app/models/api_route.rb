# frozen_string_literal: true

class ApiRoute < ApplicationRecord
  ACTIONS = %w[index show new edit create update destroy].freeze

  belongs_to :api, optional: true

  validates :actions,
            length: {
              minimum: 1,
              message: 'must have at least one action selected'
            },
            inclusion: {
              in: ACTIONS,
              message: "must be selected from: #{ACTIONS.join ', '}",
              allow_blank: true
            }
  validates :reference_name, presence: true

  def reference_name=(value)
    value = value.pluralize.parameterize if value.present?
    super(value)
  end
end
