FactoryBot.define do
  factory :state do
    sequence(:acronym) { |n| "Acronym #{n}" }
    sequence(:name) { |n| "Name #{n}" }
    region
  end
end
