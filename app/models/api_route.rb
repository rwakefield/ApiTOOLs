# frozen_string_literal: true

class ApiRoute < ApplicationRecord
  include Restful

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

  def action_data
    @action_data ||= fetch_action_data.to_json
  end

  def reference_name=(value)
    value = value.pluralize.parameterize if value.present?
    super(value)
  end

  private

  def fetch_action_data
    data = {}
    api_route_data.each do |route_data|
      key = route_data[:action].to_sym
      data[key] = route_data.except(:action)
    end
    data
  end

  def api_route_data
    @api_route_data ||= JSON.parse(api.route_data).deep_symbolize_keys.values.map do |data|
      data if data[:controller] == reference_name
    end.compact
  end
end
