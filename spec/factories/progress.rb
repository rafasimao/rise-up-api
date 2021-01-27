FactoryBot.define do
  factory :progress do
    track_type { 'tasks' }
    amount { Faker::Number.number(digits: 1) }
    max { Faker::Number.number(digits: 1) + 10 }
  end
end
