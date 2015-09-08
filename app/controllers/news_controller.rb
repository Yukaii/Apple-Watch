class NewsController < ApplicationController
  def index
    @news = News.all.page(params[:page])
    @headline = "全部新聞"
  end

  def shiyijei
    @news = News.shiyijei.page(params[:page])
    @headline = "旖婕的貼文"
    render 'index'
  end

  def run_parse_task
    if params[:token] == ENV["TASK_TOKEN"]
      AppleRealtimeNewsParser.parse_news_list(1...6)
    end
    render(json: { status: "done" }, status: 200)
  end

  def show
    @news = News.find(params[:id])
    @title = "41J | #{@news.title}"
  end

  def today
    @news = News.today.shiyijei.page(params[:page])
    @headline = "每日的旖婕"
    render 'index'
  end
end
