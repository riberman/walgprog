FactoryBot.define do
  factory :region do
    sequence(:name) { |n| "Name #{n}" }
  end
end

