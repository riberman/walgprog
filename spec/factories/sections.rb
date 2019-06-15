FactoryBot.define do
  factory :section do
    sequence(:title) { |n| "Title #{n}" }
    content { 'Content' }
    status { 'A' }
    icon { 'laptop' }
    sequence(:index) { |n| n }
    event

    trait :inactive do
      status { 'I' }
    end

    trait :other do
      status { 'O' }
      alternative_text { 'other status' }
    end
  end
end
