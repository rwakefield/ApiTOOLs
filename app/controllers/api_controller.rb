# frozen_string_literal: true

class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  helper_method :api_route

  delegate :reference_name, :schema, to: :api_route

  def index
    render json: ApiItemSerializer.new(api_items).serializable_hash, status: :ok
  end

  def show
    render json: ApiItemSerializer.new(api_item), status: :ok
  end

  def create
    schema_errors = JSON::Validator.fully_validate(schema, form_data)
    if schema_errors.empty?
      create_item
    else
      render json: schema_errors, status: :bad_request
    end
  end

  def update
    schema_errors = JSON::Validator.fully_validate(schema, form_data)
    if schema_errors.empty?
      update_item
    else
      render json: schema_errors, status: :bad_request
    end
  end

  def destroy
    api_item = api_items.find_by! uuid: params[:uuid]
    api_item.destroy!
    render json: {}, status: :ok
  end

  private

  def create_item
    record = api_route.api_items.new data: form_data
    if record.save
      render json: ApiItemSerializer.new(record), status: :created
    else
      render json: api_item.errors.full_messages, status: :internal_server_error
    end
  end

  def update_item
    api_item.data = form_data

    if api_item.save
      render json: ApiItemSerializer.new(api_item), status: :ok
    else
      render json: api_item.errors.full_messages, status: :internal_server_error
    end
  end

  def api
    @api ||= Api.find_by! uuid: params[:api_uuid]
  end

  def api_route
    @api_route ||= api.api_routes.find_by reference_name: params[:controller]
  end

  def api_item
    @api_item ||= api_items.find_by! uuid: params[:uuid]
  end

  def api_items
    @api_items ||= api_route.api_items.all
  end

  def form_data
    @form_data ||= api_route_params.to_json
  end

  def api_route_params
    @api_route_params ||= params.require(required_param).permit(schema['properties'].keys.map(&:to_sym))
  end

  def required_param
    reference_name.singularize.to_sym
  end
end
