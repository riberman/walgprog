namespace :db do
  desc 'Erase and fill database'

  task populate: :environment do
    require 'faker'

    [Event].each(&:delete_all)
    beginning_date = Faker::Date.forward(30)
    year_increment = 1
    4.times do
      city_offset = rand(City.count)
      random_city = City.offset(city_offset).first

      Event.create(
        name: Faker::Name.unique.name,
        initials: Faker::String.random(4),
        beginning_date: beginning_date + year_increment.years,
        end_date: beginning_date + year_increment.years + 1.day,
        color: Faker::Color.hex_color,
        local: Faker::Address.community,
        address: Faker::Address.full_address,
        city_id: random_city.id
      )

      year_increment += year_increment
    end
  end
end
