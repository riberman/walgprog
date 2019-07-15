FactoryBot.define do
  factory :institution do
    sequence(:name) { |n| "Institution Name #{n}" }
    sequence(:acronym) { |n| "IN#{n}" }
    city
  end
end
