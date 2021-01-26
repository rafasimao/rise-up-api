FactoryBot.define do
  factory :project do
    association :user
    association :progress
    title { Faker::Lorem.sentence }
  end
end
