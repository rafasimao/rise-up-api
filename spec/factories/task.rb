FactoryBot.define do
  factory :task do
    association :user

    title { Faker::Lorem.sentence }
    done { false }
    value_points { Faker::Number.number(digits: 1) }
    difficulty_points { Faker::Number.number(digits: 1) }
    experience_points { Faker::Number.number(digits: 1) }
  end
end
