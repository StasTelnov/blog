class ArticlesController < ApplicationController
  def create
    render ArticleCreateService.new(request).process.result
  end

  def top_rating
    render json: Article.top_rating(params[:limit])
  end

  def public_ips
    render json: Article.public_ips
  end

end
