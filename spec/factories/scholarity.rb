FactoryBot.define do
  factory :scholarity do
    sequence(:name) { |n| "Researcher #{n}" }
    sequence(:abbr) { |n| "Abbr #{n}" }
  end
end
