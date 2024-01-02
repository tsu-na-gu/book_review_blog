class CreatePages < ActiveRecord::Migration[7.1]
  def change
    create_table :pages do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :slug
      t.text :summary
      t.text :content
      t.boolean :published

      t.timestamps
    end
    add_index :pages, :title, unique: true
    add_index :pages, :slug, unique: true
    add_index :pages, :published
  end
end
