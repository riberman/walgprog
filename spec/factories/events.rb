FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "Name #{n}" }
    city
    beginning_date { 5.years.ago }
    end_date { 2.years.after }
    color { '#fff' }
    initials { 'TST' }
    local { 'Parque' }
    address { 'testing' }
  end
end
