FactoryBot.define do
  factory :contact do
    sequence(:name) { |n| 'Contact_name_#{n}' }
    sequence(:email) { |n| "admin#{n}@admin.com" }
    phone { '99888887777' }
    institution
  end
end