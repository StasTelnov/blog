RatingCreateSchema = Dry::Validation.Form do
  required(:rating).schema do
    required(:value).filled(included_in?: [1, 2, 3, 4, 5])
  end
end
