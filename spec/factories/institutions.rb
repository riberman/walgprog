FactoryBot.define do
  factory :institution do
    sequence(:name) { |n| "Institution Name #{n}" }
    sequence(:acronym) { |n| "IN#{n}" }
    city
    approved { 'yes' }
  end

  trait :approved do
    approved { 'yes' }
  end

  trait :unapproved do
    approved { 'not' }
  end
end
