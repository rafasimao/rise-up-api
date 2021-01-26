FactoryBot.define do
  factory :area do
    association :user
    association :progress
    title { Faker::Lorem.sentence }
  end
end
