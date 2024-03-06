# frozen_string_literal: true

class ApiControllerGenerator < Rails::Generators::Base
  def create_controller_file
    Api.find_each do |api|
      api.api_routes.find_each do |route|
        create_file "app/controllers/#{route.reference_name}_controller.rb", <<~RUBY
          # frozen_string_literal: true

          # NOTE: This file is auto generated

          class #{route.reference_name.camelize}Controller < ApplicationController
            def index
              respond_success
            end

            def show
              respond_success
            end

            def new
              respond_success
            end

            def edit
              respond_success
            end

            def create
              respond_success
            end

            def update
              respond_success
            end

            def destroy
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
        RUBY
      end
    end
  end
end
