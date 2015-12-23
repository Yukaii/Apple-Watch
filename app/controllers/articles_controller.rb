class ArticlesController < ApplicationController
  def index
    @articles = Article.all.page(params[:page])
    @headline = "全部新聞"
  end

  def shiyijei
    @articles = Article.shiyijei.page(params[:page])
    @headline = "旖婕的貼文"
    render 'index'
  end

  def run_parse_task
    if params[:token] == ENV["TASK_TOKEN"]
      AppleRealtimeNewsParser.parse_article_list(1...6)
    end
    render(json: { status: "done" }, status: 200)
  end

  def show
    @article = Article.find(params[:id])
    @title = "41J | #{@article.title}"
    @og_image = @article.image_url
  end

  def today
    @articles = Article.today.shiyijei.page(params[:page])
    @headline = "每日的旖婕"
    render 'index'
  end
end
