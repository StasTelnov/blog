FactoryGirl.define do
  factory :rating do
    value { rand(1..5) }
    association :article, factory: :article
  end
end


