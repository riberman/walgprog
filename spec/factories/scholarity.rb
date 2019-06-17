FactoryBot.define do
  factory :scholarity do
    sequence(:name) { |n| "Scholarity#{n}" }
    sequence(:abbr) { |n| "Abbr #{n}" }
  end
end
