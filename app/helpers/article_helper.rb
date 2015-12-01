module ArticleHelper
  def render_published_date(article)
    article.published_at.present? ? "#{article.published_at.strftime("%Y-%m-%d")} " : ""
  end

  def render_published_timestamp(article)
    article.published_at.present? ? article.published_at.iso8601 : ""
  end
end
