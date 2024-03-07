# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get 'welcome/index'

  if ActiveRecord::Base.connection.table_exists? 'apis'
    concern :routable, Api
    Api.find_each do |api|
      resources :api, param: :uuid do
        concerns :routable, api: api
      end
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'welcome#index'
end
