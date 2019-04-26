FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "Name #{n}" }
    city
    beginning_date { Time.zone.now }
    end_date { Time.zone.now + 10.days }
    color { '#fff' }
    initials { 'TST' }
    local { 'Parque' }
    address { 'testing' }
  end
end
