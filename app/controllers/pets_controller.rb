# frozen_string_literal: true

class PetsController < ApplicationController
  helper_method :api_route

  delegate :data, to: :api_route

  def index
    respond_success
  end

  private

  def api
    @api ||= Api.find_by! uuid: params[:api_uuid]
  end

  def api_route
    @api_route ||= api.api_routes.find_by reference_name: params[:controller]
  end

  def respond_success
    respond_to do |format|
      msg = { data: data }
      format.json { render json: msg }
    end
  end
end
