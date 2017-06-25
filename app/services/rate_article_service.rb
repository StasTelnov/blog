class RateArticleService
  def initialize(request)
    @request = request
    @schema = RateArticleSchema
  end

  def process
    result = validate

    if result.success?
      average_rating = 0
      article = Article.find(@request.params[:id])

      article.with_lock do
        article.ratings.create(:value => result.output[:article][:rating])
        average_rating = Article.joins(:ratings).where('articles.id' => article.id).average(:value)
        article.update_attributes(:average_rating => average_rating)
      end

      ResultService.new(true, average_rating)
    else
      ResultService.new(false, result.messages)
    end
  end

  private

  def validate
    @schema.call(params)
  end

  def params
    @request.parameters
  end
end
