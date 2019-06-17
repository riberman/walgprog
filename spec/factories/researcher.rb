FactoryBot.define do
  factory :researcher do
    sequence(:name) { |n| "Researcher#{n}" }
    gender { Researcher.genders.keys.sample }
    institution
    scholarity

    trait :with_image do
      image { FileSpecHelper.image }
    end
  end
end
