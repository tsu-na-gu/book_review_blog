ActiveAdmin.register Image do
  permit_params :name, :image
  filter :name
  remove_filter :image_blob, :image_attachment

  form do |f|
    f.inputs do
      f.input :name
      f.input :image, as: :file,
                      hint: if f.object.image.attached?
                              image_tag(url_for(f.object.image), height: 360)
                            else
                              content_tag(:span, 'まだ画像がアップロードされていません。')
                            end
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column 'Image' do |i|
      image_tag image_path(i),
                height: 80,
                alt: i.name,
                title: i.name
    end
    column 'Image Tag' do |i|
      "#{image_tag(image_path(i), alt: i.name, title: i.name)}"
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row 'Image' do |i|
        image_tag image_path(i),
                  height: 80,
                  alt: i.name,
                  title: i.name
      end
      row 'Image Tag' do |i|
        "#{ image_tag(image_path(i), alt: i.name, title: i.name) }"
      end
    end
  end
end
