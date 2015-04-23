class NewsController < ApplicationController
  def index
    @news = News.shiyijei
  end
end
