require 'rails_helper'

RSpec.describe 'Tag', type: :system do
  let(:page_1) { create(:page, :published, tags_string: 'foo, bar') }
  let(:page_2) { create(:page, :published, tags_string: 'bar') }

  before do
    [page_1, page_2]
  end

  it 'displays clickable tags on page' do
    visit root_path

    find_link(href: '/tags/foo').click
    expect(page).to have_content(page_1.title)
    expect(page).to_not have_content(page_2.title)

    find_link(href: '/tags/bar', match: :first).click
    expect(page).to have_content(page_1.title)
    expect(page).to have_content(page_2.title)
  end

  context 'when a tag does not exist' do
    it 'redirects to the toot path' do
      visit '/tags/does-not-exist'
      expect(page).to have_current_path(root_path)
    end
  end
end
