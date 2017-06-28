ArticleCreateSchema = Dry::Validation.Form do
  required(:article).schema do
    required(:title).filled(:str?)
    required(:content).filled(:str?)
    required(:user_ip).filled(:str?)
  end
  required(:user).schema do
    required(:nickname).filled(:str?)
  end
end

