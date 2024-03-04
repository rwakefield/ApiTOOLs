# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Viewing the Welcome Page', type: :system do
  it 'has the correct content' do
    visit root_path

    expect(page).to have_content('Welcome#index')
  end
end
