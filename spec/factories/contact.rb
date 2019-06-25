FactoryBot.define do
  factory :contact do
    sequence(:name) { |n| "Contact_name_#{n}" }
    sequence(:email) { |n| "admin#{n}@admin.com" }
    phone { '(55) 77777-8888' }
    institution
    unregister_token { 'b89p9zHfGU4ioWt_bL_lTg' }
    update_data_token { 'x03t9zHfCU4iuYt_bP_lZg' }
    update_data_send_at { Time.zone.now }
  end
end
