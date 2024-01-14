require 'rails_helper'

RSpec.describe 'Login Page' do
  let(:user) { create(:user) }

  it 'Admin requires logging in' do
    visit admin_root_path

    expect(page).to have_css('h2', text: '管理ページへサインイン')

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'changeme'
    click_button 'Submit'

    expect(page).to have_css('h2', text: 'ダッシュボード')
    expect(page).to have_css('h2', text: '管理ページ')

    click_link 'ログアウト'

    expect(page).to have_link "Tsu-na-gu's book reviews"
  end
end
