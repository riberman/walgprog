FactoryBot.define do
  factory :admin do
    name { 'Administrator' }
    sequence(:email) { |n| "admin#{n}@admin.com" }
    password { 'password' }
    password_confirmation { 'password' }
    user_type { 'C' }

    trait :with_image do
      image { FileSpecHelper.image }
    end

    trait :administrator do
      user_type { 'A' }
    end

    trait :collaborator do
      user_type { 'C' }
    end
  end
end
