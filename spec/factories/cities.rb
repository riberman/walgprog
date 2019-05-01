FactoryBot.define do
  factory :city do
    sequence(:name) { |n| "City #{n}" }
    state
  end
end
