FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "Name #{n}" }
    sequence(:beginning_date) { |i| Time.zone.now + i.years }
    sequence(:end_date) { |i| Time.zone.now + i.years + + 10.days }
    color { '#AA33DD' }
    initials { 'TST' }
    local { 'Parque' }
    address { 'testing' }
    city
  end
end
