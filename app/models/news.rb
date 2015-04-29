class News < ActiveRecord::Base
  default_scope { order(created_at: :desc) }
  scope :shiyijei, -> { where(author: "施旖婕") }
  scope :today, -> { where('DATE(published_at) = ?', Date.today) }

  def update_apple_popularity
    AppleRealtimeNewsParser.update_popularity(self)
  end

  def shared_on_facebook
    data = {
        "message" => "\#41J機器人: #{self.title}",
        "link" => "#{ENV['DEPLOY_DOMAIN']}#{Rails.application.routes.url_helpers.news_path(self)}",
        "name" => self.title,
        "description" => self.content,
        "caption" => "#{self.published_at.strftime('%F %T')} #{self.author}",
        "picture" => self.image_url,
        # "published" => false,
        # "scheduled_publish_time" => (DateTime.now + 10.minutes).to_i
      }
    r = RestClient.post(
      "https://graph.facebook.com/v2.3/#{ENV['FB_PAGE_ID']}/feed?access_token=#{ENV['FB_ACCESS_TOKEN']}", data
    ) {|response, request, result, &block|
      # binding.pry
      # puts "ui"
    }
    self.shared_at = DateTime.now
    self.save!
  end
end
