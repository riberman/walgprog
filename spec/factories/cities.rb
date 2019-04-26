FactoryBot.define do
  factory :city do
    sequence(:name) { |n| "Name #{n}" }
    state
  end
end
