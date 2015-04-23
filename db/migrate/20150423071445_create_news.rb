class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string  :title
      t.string  :url
      t.string  :author
      t.string  :report_type
      t.text    :content
      t.integer :category_id
      t.date    :published_at
      t.integer :popularity

      t.timestamps null: false
    end
    add_index :news, :url
    add_index :news, :author
  end
end
