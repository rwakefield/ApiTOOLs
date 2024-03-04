# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'WelcomeController', type: :request do
  describe '#index' do
    it 'renders' do
      get '/welcome/index'

      expect(response).to have_http_status :ok
    end
  end
end
