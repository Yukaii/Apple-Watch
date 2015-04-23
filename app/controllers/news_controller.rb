class NewsController < ApplicationController
  def index
    @news = News.all
  end
end
