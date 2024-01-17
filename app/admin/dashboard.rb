# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: 'ダッシュボード' do
    panel 'Book Pages' do
      table_for Page.order(created_at: :desc).limit(10) do
        column '最近追加されたページ' do |page|
          span link_to page.title, admin_page_path(page)
          span ' '
          span page.author
          span ' '
          span page.publisher
        end
      end
      section 'クイックリンク' do
        span link_to '新規作成', new_admin_page_path
      end
    end

    panel 'Images List' do
        table_for Image.order(created_at: :desc).limit(3) do
          column "最近追加された画像" do |image|
            if image.image.attached?
              span image_tag(url_for(image.image.attachment), height: '80px')
            end
            span link_to image.name, admin_image_path(image)
          end
        end
      section 'クイックリンク' do
        span link_to '新規作成', new_admin_image_path
      end
    end

  end
end


