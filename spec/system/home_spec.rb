# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home' do
  it 'renders homepage' do
    visit root_path
    within 'header' do
      expect(page).to have_link "Tsu-na-gu's book reviews"
    end
  end

  describe 'pagenation' do
    context 'with many pages' do
      it 'paginates' do
        create_list(:page, 26, :published)

        visit root_path

        articlies = find_all('article')
        expect(articlies.size).to eq(25)
        expect(page).to have_link('Next')
      end
    end
  end
end
