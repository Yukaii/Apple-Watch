class ChangeDateInNews < ActiveRecord::Migration
  def up
    change_column :news, :published_at, :datetime
  end

  def down
    change_column :news, :published_at, :date
  end
end
