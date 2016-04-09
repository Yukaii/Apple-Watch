module ArticleHelper
  def render_published_date(article)
    article.try(:published_at).strftime("%Y-%m-%d")
  end

  def render_published_timestamp(article)
    article.try(:published_at).iso8601
  end
end
