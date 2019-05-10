namespace :db do
  desc 'Erase and fill database'

  task populate: :environment do
    require 'faker'

    [Event].each(&:delete_all)

    beginning_date = Faker::Date.forward(30)
    city_ids = City.limit(4).pluck(:id)

    4.times do |i|
      beginning_date += i.years
      end_date = beginning_date + i.years + 1.day

      Event.create(
        name: Faker::Name.unique.name,
        initials: Faker::Lorem.word.upcase,
        beginning_date: beginning_date,
        end_date: end_date,
        color: Faker::Color.hex_color,
        local: Faker::Address.community,
        address: Faker::Address.full_address,
        city_id: city_ids.sample
      )
    end
  end
end
