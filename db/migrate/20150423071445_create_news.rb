class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string  :title
      t.string  :url
      t.string  :author
      t.text    :content
      t.integer :category_id
      t.date    :published_at

      t.timestamps null: false
    end
    add_index :news, :url
  end
end
