RateArticleSchema = Dry::Validation.Form do
  required(:article).schema do
    # required(:id).filled(:int?)
    required(:rating).filled(:int?, :included_in? => [1, 2, 3, 4, 5])
  end
end
