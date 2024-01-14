require 'rails_helper'

RSpec.describe 'Admin Pages' do
  let(:user) { create(:user) }

  before do
    user
  end

  describe 'A new page' do
    it 'can be added' do
      visit admin_root_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'changeme'
      click_button 'Submit'

      expect(page).to have_css('h2', text: 'ダッシュボード')

      visit new_admin_page_path

      select User.last.name, from: 'User'

      fill_in 'Title', with: 'Page Ttile'
      fill_in 'Slug', with: 'page-title'
      fill_in 'Author', with: 'David Harris'
      fill_in 'page_publisher', with: 'Pagmatic Bookshelf'
      fill_in 'page_publisher_url', with: 'https://pragprog.com/'
      fill_in 'Summary', with: 'Summary info'
      fill_in 'Content', with: 'Content goes here'
      fill_in 'Tags', with: 'foo, bar'

      check('Published')

      click_button 'Pageを作成'
      expect(current_path).to match(/\/admin\/pages\/\d+/)


      within '#main_content' do
        expect(page).to have_css('td', text: user.name)
        expect(page).to have_css('td', text: 'Page Ttile')
        expect(page).to have_css('td', text: 'page-title')
        expect(page).to have_css('td', text: 'Pagmatic Bookshelf')
        expect(page).to have_css('td', text: 'https://pragprog.com/')
        expect(page).to have_css('td', text: 'Summary info')
        expect(page).to have_css('td', text: 'Content goes here')
        expect(page).to have_css('span.yes', text: 'はい')
        expect(page).to have_css('td', text: 'bar, foo')
      end
    end
  end

  describe 'An exisiting page' do
    let(:the_page) { create(:page, :published, user:) }
    let(:user2) { create(:user) }

    before do
      the_page.tags << create(:tag, name: 'foo')
      the_page.tags << create(:tag, name: 'bar')
      user2
    end

    it 'can be edited' do
      visit admin_root_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'changeme'
      click_button 'Submit'

      expect(page).to have_css('h2', text: 'ダッシュボード')

      visit admin_pages_path

      click_link '編集'

      expect(page).to have_select("page_user_id", selected: user.name)
      expect(page).to have_field("page_title", with: the_page.title)
      expect(page).to have_field("page_author", with: the_page.author)
      expect(page).to have_field("page_publisher", with: the_page.publisher)
      expect(page).to have_field("page_publisher_url", with: the_page.publisher_url)
      expect(page).to have_field("page_summary", with: the_page.summary)
      expect(page).to have_field("page_content", with: the_page.content)
      expect(page).to have_field("page_tags_string", with: 'bar, foo')
      expect(page).to have_checked_field('page_published')

      select user2.name, from: 'User'

      fill_in 'Title', with: 'Page Ttile'
      fill_in 'Slug', with: 'page-title'
      fill_in 'Author', with: 'David Harris'
      fill_in 'page_publisher', with: 'Pagmatic Bookshelf'
      fill_in 'page_publisher_url', with: 'https://pragprog.com/'
      fill_in 'Summary', with: 'Summary info'
      fill_in 'Content', with: 'Content goes here'
      fill_in 'Tags', with: 'foo, bar, baz'

      check('Published')

      click_button('Pageを更新')

      within '#main_content' do
        expect(page).to have_css('td', text: user2.name)
        expect(page).to have_css('td', text: 'Page Ttile')
        expect(page).to have_css('td', text: 'page-title')
        expect(page).to have_css('td', text: 'David Harris')
        expect(page).to have_css('td', text:  'Pagmatic Bookshelf')
        expect(page).to have_css('td', text:  'https://pragprog.com/')
        expect(page).to have_css('td', text: "Summary info")
        expect(page).to have_css('td', text: "Content goes here")
        expect(page).to have_css('span.status_tag', text: 'はい')
        expect(page).to have_css('td', text: 'bar, baz, foo')
      end
    end

    describe 'An index page' do
      let(:the_page) { create(:page, :published, user:) }


      it 'can be visited' do
        visit admin_root_path

        expect(current_path).to match(/\/login/)

        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'changeme'
        click_button 'Submit'

        expect(page).to have_css('h2', text: 'ダッシュボード')

        visit admin_pages_path

        expect(current_path).to match(/\/admin\/pages/)

        within '.index_content' do
          expect(page).to have_css('td', text: the_page.title)
          expect(page).to have_css('td', text: 'bar, foo')
          expect(page).to have_css('span.status_tag', text: 'はい')

          new_window = window_opened_by do
            click_link("page/#{the_page.slug}")
          end

          within_window new_window do
            expect(page).to have_css('h1', text: the_page.title)
          end
        end
      end
    end
  end
end
