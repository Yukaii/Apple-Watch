class News < ActiveRecord::Base
  default_scope { order(created_at: :desc) }
  scope :shiyijei, -> { where(author: "施旖婕") }
  scope :today, -> { where('DATE(published_at) = ?', Date.today) }

  def update_apple_popularity
    AppleRealtimeNewsParser.update_popularity(self)
  end
end
