namespace :db do
  desc 'Erase and fill database'

  task populate: :environment do
    require 'faker'

    delete_all
    cities
    contacts
    events
    admins
    researchers
  end

  def delete_all
    [Contact, Institution, Researcher].each(&:delete_all)
    Admin.where.not(email: 'admin@admin.com').destroy_all
  end

  def cities
    Rake::Task['db:seeds:cities'].invoke
    Rake::Task['db:seeds:institutions'].invoke
  end

  def contacts
    10.times do
      Contact.create(
        name: Faker::Name.unique.name,
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.cell_phone,
        institution: Institution.all.sample
      )
    end
  end

  def events
    beginning_date = Faker::Date.forward(30)
    city_ids = City.limit(4).pluck(:id)

    4.times do |i|
      beginning_date += i.years
      end_date = beginning_date + i.years + 1.day

      Event.create(
        name: Faker::Name.unique.name, initials: Faker::Lorem.word.upcase,
        beginning_date: beginning_date, end_date: end_date,
        color: Faker::Color.hex_color, local: Faker::Address.community,
        address: Faker::Address.full_address, city_id: city_ids.sample
      )
    end
  end

  def admins
    5.times do
      Admin.create!(
        name: Faker::Name.unique.name,
        email: Faker::Internet.unique.email,
        user_type: Admin.user_types.keys.sample,
        password: '123456',
        password_confirmation: '123456'
      )
    end
  end

  def researchers
    10.times do
      Researcher.create(
        name: Faker::Name.unique.name,
        genre: Faker::Gender.binary_type,
        scholarity: Scholarity.all.sample,
        institution: Institution.all.sample
      )
    end
  end
end
