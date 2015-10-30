module NewsHelper
  def render_published_date(news)
    news.published_at.present? ? "#{news.published_at.strftime("%Y-%m-%d")} " : ""
  end

  def render_published_timestamp(news)
    news.published_at.present? ? news.published_at.iso8601 : ""
  end
end
