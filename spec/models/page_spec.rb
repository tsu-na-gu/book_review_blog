require 'rails_helper'

RSpec.describe Page, type: :model do
  # let(:page) { build(:page) }
  subject { build(:page) }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:publisher) }
    it { is_expected.to validate_presence_of(:publisher_url) }
    it { is_expected.to validate_presence_of(:content) }
  end

  # describe '#slug' do
  #   let(:page) { create(:page, title: '--Foo Bar! _ 87 --') }
  #
  #   it 'is generated from the title' do
  #     expect(page.slug).to eq('foo-bar-87')
  #   end
  # end

  describe 'scopes' do
    describe '.published' do
      let(:page1) { create(:page, :published) }
      let(:page2) { create(:page) }

      before do
        [page1, page2]
      end

      it 'return only pushed pages' do
        expect(Page.published).to eq([page1])
      end
    end

    describe '.ordered' do
      let(:page1) { create(:page, created_at: 2.days.ago) }
      let(:page2) { create(:page, created_at: 1.day.ago) }

      before do
        [page1, page2]
      end

      it 'returns ordered pages' do
        expect(Page.ordered).to eq([page2, page1])
      end
    end

    describe '.by_term' do
      let(:page1) { create(:page, content: 'foo') }
      let(:page2) { create(:page, content: 'foo bar') }
      let(:page3) { create(:page, content: 'foo bar baz') }

      before { [page1, page2, page3] }

      it 'returns pages for the given term' do
        expected = [page1, page2, page3]
        expect(Page.by_term('foo')).to match_array(expected)
      end

      it 'returns pages for multiple terms' do
        expected = [page3]
        expect(Page.by_term('foo baz')).to match_array(expected)
      end

      it 'return pages for mutiple term in ja space' do
        expected = [page2, page3]
        expect(Page.by_term('foo　bar')).to match_array(expected)
      end
    end

    describe '.month_year_list' do
      let(:result) { Page.month_year_list }

      before do
        create(:page, created_at: Date.new(2022, 7, 4))
        create(:page, :published, created_at: Date.new(2022, 8, 10))
        create(:page, :published, created_at: Date.new(2022, 8, 11))
        create(:page, :published, created_at: Date.new(2021, 3, 13))
      end

      it 'returns a list of results' do
        expect(result.count).to eq(2)
      end

      it 'returns month and year' do
        expect(result[0]['month_name']).to eq('August')
        expect(result[0]['month_number']).to eq('08')
        expect(result[0]['year']).to eq('2022')

        expect(result[1]['month_name']).to eq('March')
        expect(result[1]['month_number']).to eq('03')
        expect(result[1]['year']).to eq('2021')
      end
    end

    describe '.by_year_month' do
      let(:page1) { create(:page, created_at: Date.new(2022, 8, 10)) }
      let(:page2) { create(:page, created_at: Date.new(2021, 4, 13)) }

      before do
        [page1, page2]
      end

      it 'returns pages for the given year and month' do
        expect(Page.by_year_month(2021, 4)).to match_array([page2])
      end
    end
  end
end
