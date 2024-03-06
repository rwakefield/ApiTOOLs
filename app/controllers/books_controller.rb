# frozen_string_literal: true

# NOTE: This file is auto generated

class BooksController < ApplicationController
  def index
    respond_success
  end

  def show
    respond_success
  end

  private

  def respond_success
    respond_to do |format|
      msg = { status: 'ok', message: 'Success!' }
      format.json { render json: msg }
    end
  end
end
