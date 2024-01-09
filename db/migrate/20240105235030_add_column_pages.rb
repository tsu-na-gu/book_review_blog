class AddColumnPages < ActiveRecord::Migration[7.1]
  def change
    add_column :pages, :author, :string
    add_column :pages, :publisher,:string
  end
end
