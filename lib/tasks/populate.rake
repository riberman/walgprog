namespace :db do
  desc 'Erase and fill database'

  task populate: :environment do
    require 'faker'

    delete_all
    cities
    contacts
  end

  def delete_all
    [Contact, Institution].each(&:delete_all)
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
end
