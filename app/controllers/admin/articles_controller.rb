class Admin::ArticlesController < Admin::BaseController
  before_filter :authenticate_admin_user!

  def index

  end
end
