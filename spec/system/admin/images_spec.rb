require 'rails_helper'

RSpec.describe 'Images' do
  let(:user) { create(:user) }
  let(:img) { Image.last }

  before do
    login_as(user)
  end

  describe 'index' do
    before do
      create(:image)
    end

    it 'renders images' do
      visit admin_images_path

      expect(current_path).to match(/\/admin\/images/)

      within 'table.index_table' do
        within 'td.col-name' do
          expect(page).to have_text(img.name)
        end

        within 'td.col-image' do
          element = find('img')
          expect(element[:height]).to eq("80")
          expect(element[:alt]).to eq("#{img.name}")
          expect(element[:title]).to eq("#{img.name}")
          expect(element[:src]).to match(/\/images\/#{img.id}/)
        end

        within 'td.col-image_tag' do
          text = <<-IMG.squish
            <img alt="#{img.name}"
                 title="#{img.name}"
                  src="/images/#{img.id}" />
          IMG
          expect(page).to have_text(text)
        end
      end
    end
  end

  describe 'new' do
    it 'uploads an image' do
      visit new_admin_image_path

      fill_in 'Name', with: 'Name'
      files = Rails.root.join('spec/factories/images/inage.jpeg')
      attach_file 'Image', files
      click_button 'Imageを作成'

      within '.image table' do
        within 'tr.row-name td' do
          expect(page).to have_text(img.name)
        end

        within 'tr.row-image td' do
          element = find('img')
          expect(element[:height]).to eq("80")
          expect(element[:alt]).to eq("#{img.name}")
          expect(element[:title]).to eq("#{img.name}")
          expect(element[:src]).to match(/\/images\/#{img.id}/)
        end

        within 'tr.row-image_tag td' do
          text = <<-IMG.squish
            <img alt="#{img.name}"
                 title="#{img.name}"
                  src="/images/#{img.id}" />
          IMG
          expect(page).to have_text(text)
        end
      end
    end
  end

  describe 'edit' do
    let(:img) { Image.last }
    let(:name) { 'New Name'}

    before do
      create(:image)
    end

    it 'updates an image' do
      visit edit_admin_image_path(img)

      within 'form.image' do
        within '.inline-hints' do
          element = find('img')
          expect(element[:height]).to eq("360")
        end
      end


      fill_in 'image_name', with: name
      files = Rails.root.join('spec/factories/images/inage.jpeg')
      attach_file 'Image', files
      click_button 'Imageを更新'

      img.reload

      within '.image table' do
        within 'tr.row-name td' do
          expect(page).to have_text(name)
        end

          within 'tr.row-image td' do
            element = find('img')
            expect(element[:height]).to eq("80")
            expect(element[:alt]).to eq(name)
            expect(element[:title]).to eq(name)
            expect(element[:src]).to match(/\/images\/#{img.id}/)
        end
      end
    end
  end
end
