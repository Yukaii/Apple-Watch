class NewsObserver < ActiveRecord::Observer
  observe :news

  def after_create(news)
    news.shared_on_facebook if news.yijei?
  end
end
