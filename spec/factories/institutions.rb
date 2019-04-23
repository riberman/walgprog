FactoryBot.define do
  factory :institution do
    sequence(:name) { |n| "Name #{n}" }
    acronym { 'IN' }
    city
  end
end
