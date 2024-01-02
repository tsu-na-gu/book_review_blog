# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home' do
  it 'renders homepage' do
    visit root_path
    within 'header' do
      expect(page).to have_link "Tsu-na-gu's book reviews"
    end
  end
end
