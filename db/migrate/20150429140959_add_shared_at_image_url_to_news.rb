class AddSharedAtImageUrlToNews < ActiveRecord::Migration
  def change
    add_column :news, :shared_at, :datetime
    add_column :news, :image_url, :string
  end
end
