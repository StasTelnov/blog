FactoryGirl.define do
  factory :article do
    title       { Faker::Name.title }
    content     { Faker::Lorem.paragraph }
    user_ip     { Faker::Internet.ip_v4_address }
    association :user, factory: :user
  end

  factory :article_with_ratings do
    after(:create) do |article|
      rand(5..10).times { create(:rating, { :article => article }) }
    end
  end
end


