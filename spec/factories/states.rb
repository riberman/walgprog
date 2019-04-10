FactoryBot.define do
  factory :state do
    sequence(:symbol) { |n| "Symbol #{n}" }
    sequence(:name) { |n| "Name #{n}" }
  end
end
