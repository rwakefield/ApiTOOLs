require "rails_helper"

RSpec.describe "WelcomeController", type: :request do
  context '#index' do
    it "will render" do
      get "/welcome/index"

      expect(response).to have_http_status :ok
    end
  end
end
