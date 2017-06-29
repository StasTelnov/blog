ArticleCreateSchema = Dry::Validation.Form do
  block = /\d{,2}|1\d{2}|2[0-4]\d|25[0-5]/
  ip_regexp = /\A#{block}\.#{block}\.#{block}\.#{block}\z/

  required(:article).schema do
    required(:title).filled(:str?)
    required(:content).filled(:str?)
    required(:user_ip).filled(:str?, format?: ip_regexp)
  end
  required(:user).schema do
    required(:nickname).filled(:str?)
  end
end

