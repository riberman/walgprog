FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "Name #{n}" }
    sequence(:beginning_date) { |i| Time.zone.now + i.years }
    sequence(:end_date) { |i| Time.zone.now + i.years + + 10.days }
    color { '#AA33DD' }
    initials { 'TST' }
    local { 'Parque' }
    address { 'testing' }
    city

    transient do
      institutions_count { 3 }
      sections_count { 5 }
    end

    trait :with_sponsors do
      after(:create) do |event, evaluator|
        create_list(:sponsor_event, evaluator.institutions_count, event: event)
      end
    end

    trait :with_sections do
      after(:create) do |event, evaluator|
        create_list(:section, evaluator.sections_count, event: event)
      end
    end
  end
end
