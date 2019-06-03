FactoryBot.define do
  factory :admin do
    name { 'Administrator' }
    sequence(:email) { |n| "admin#{n}@admin.com" }
    password { 'password' }
    password_confirmation { 'password' }
    user_type { 'A' }

    trait :with_image do
      image { FileSpecHelper.image }
    end
  end
end
