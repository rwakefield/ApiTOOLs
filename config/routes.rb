# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get 'welcome/index'

  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'welcome#index'
end
