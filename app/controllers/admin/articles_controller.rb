class Admin::ArticlesController < Admin::BaseController
  before_filter :authenticate_admin_user!

  def index
    @articles = Admin::Article.all.page(params[:page]).per(20)
  end

  def show
    @article = Admin::Article.find(params[:id])
  end
end
