class NewsController < ApplicationController
  def index
    @news = News.all.page(params[:page])
  end

  def shiyijei
    @news = News.shiyijei.page(params[:page])
    render 'index'
  end

  def run_parse_task
    if params[:token] == ENV["TASK_TOKEN"]
      AppleRealtimeNewsParser.parse_news_list(1...6)
    end
    render(json: { status: "done" }, status: 200)
  end
end
