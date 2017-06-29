class ArticleCreateService
  def initialize(request)
    @request = request
    @schema = ArticleCreateSchema
  end

  def process
    result = validate

    if result.success?
      article = Article.new(result.output[:article])
      article.user = User.find_or_create_by(nickname: result.output[:user][:nickname])
      article.save!

      ResultService.new(true, article)
    else
      ResultService.new(false, result.messages)
    end
  end

  private

  def validate
    @schema.call(@request.parameters)
  end

end



