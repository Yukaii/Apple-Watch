module NewsHelper
  def render_published_date(news)
    news.published_at.present? ? "#{news.published_at.strftime("%Y-%m-%d")} " : ""
  end
end
