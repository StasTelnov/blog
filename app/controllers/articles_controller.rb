class ArticlesController < ApplicationController
  def create
    service = ArticleCreateService.new(request).process

    if service.success?
      render json: service.result
    else
      render json: service.result, status: 422
    end
  end

  def top_rating
    render json: Article.top_rating(params[:limit])
  end

  def public_ips
    render json: Article.public_ips
  end

end
