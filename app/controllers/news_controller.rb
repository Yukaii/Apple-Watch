class NewsController < ApplicationController
  def index
    @news = News.all.page(params[:page])
  end

  def shiyijei
    @news = News.shiyijei.page(params[:page])
    render 'index'
  end
end
