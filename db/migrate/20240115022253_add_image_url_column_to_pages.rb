class AddImageUrlColumnToPages < ActiveRecord::Migration[7.1]
  def change
    add_column :pages, :image_url, :string
  end
end
