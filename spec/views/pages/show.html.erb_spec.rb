require 'rails_helper'

RSpec.describe 'pages/show', type: :view do
  let(:page) { build(:page) }

  it 'renders the page object' do
    assign(:page, page)
    render
    expect(rendered).to have_css('h1', text: page.title)
    expect(rendered).to have_css('span', text: page.created_at.to_date.to_fs(:local))
    expect(rendered).to have_css('p', text: 'content')
  end
end
