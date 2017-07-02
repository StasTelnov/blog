class RatingCreateService
  def initialize(request)
    @request = request
    @schema = RatingCreateSchema
  end

  def process
    result = validate

    if result.success?
      average_rating = 0
      article = Article.find(@request.params[:article_id])

      article.with_lock do
        article.ratings.create(value: result.output[:rating][:value])
        average_rating = Rating.where('article_id' => article.id).average(:value)
        article.update_attributes(average_rating: average_rating)
      end

      ResultService.new(true, average_rating: average_rating)
    else
      ResultService.new(false, result.messages)
    end

  rescue ActiveRecord::RecordNotFound => e
    ResultService.new(false, { article: e.message }, 404)
  end

  private

  def validate
    @schema.call(@request.parameters)
  end
end
