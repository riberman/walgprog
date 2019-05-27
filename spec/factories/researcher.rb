FactoryBot.define do
  factory :researcher do
    sequence(:name) { |n| "Researcher#{n}" }
    genre { 'Genero' }
    institution
    scholarity

    trait :with_image do
      image { FileSpecHelper.image }
    end
  end
end
