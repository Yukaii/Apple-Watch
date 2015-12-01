class ArticleObserver < ActiveRecord::Observer
  observe :article

  def after_create(article)
    article.shared_on_facebook if article.yijei?
  end
end
