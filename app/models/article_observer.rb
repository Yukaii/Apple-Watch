class ArticleObserver < ActiveRecord::Observer
  observe :article

  def after_create(article)
    # article.shared_on_facebook if article.yijei?
    ShareArticleWorker.perform_async(article.id) if article.yijei? && !article.shared_at
  end
end
