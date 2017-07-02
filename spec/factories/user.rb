FactoryGirl.define do
  factory :user do
    nickname { Faker::Internet.unique.user_name }
  end
end
