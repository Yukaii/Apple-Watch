class ShareArticleWorker
  include Sidekiq::Worker
  def perform article_id
    article = Article.find(article_id)

    post_data = {
      "message"     => "\#41J機器人: #{article.title}",
      "link"        => article.url,
      "name"        => article.title,
      "description" => article.text_content,
      "caption"     => "#{article.published_at && article.published_at.strftime('%F %T')} #{article.author}",
      "picture"     => article.image_url,
      # "published" => false,
      # "scheduled_publish_time" => (DateTime.now + 10.minutes).to_i
    }

    r = RestClient.post(
      "https://graph.facebook.com/v2.3/#{ENV['FB_PAGE_ID']}/feed?access_token=#{ENV['FB_ACCESS_TOKEN']}", post_data
    ) {|response, request, result, &block|
      Rails.logger.debug(response)
      Rails.logger.debug(result)
    }
    article.shared_at = DateTime.now
    article.save!
  end
end
