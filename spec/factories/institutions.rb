FactoryBot.define do
  factory :institution do
    sequence(:name) { |n| "Institution Name #{n}" }
    acronym { 'IN' }
    city
  end
end
