require 'rails_helper'

RSpec.describe 'HomePage', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get root_path
      expect(response).to be_successful
    end
  end
  describe 'GET /sitemp' do
    let(:tag) { create(:tag) }
    let!(:page) do
      create(
        :page,
        :published,
        tags: [tag],
        created_at: '2023-02-19'
      )
    end

    it 'returns http success' do
      get sitemap_path(format: :xml)
      expect(response).to be_successful

      doc = Nokogiri::XML(response.body)
      urls = doc.css('loc').collect(&:text)
      paths = urls.map { |url| URI.parse(url).path }

      expect(paths).to include(page_path(slug: page.slug))
    end
  end
end
