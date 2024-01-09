class Add < ActiveRecord::Migration[7.1]
  def change
    add_column :pages, :publisher_url, :string
  end
end
