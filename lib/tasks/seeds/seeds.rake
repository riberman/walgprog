require 'csv'

namespace :db do
  namespace :seeds do
    desc 'Populate regions, states, and cities'
    task cities: :environment do
      CSV.foreach('./lib/tasks/seeds/data/estados.csv') do |row|
        region = Region.find_or_create_by(name: row[2])
        State.create_with(name:  row[0], acronym: row[1], region: region)
             .find_or_create_by!(acronym: row[1])
      end

      CSV.foreach('./lib/tasks/seeds/data/municipios.csv') do |row|
        state = State.find_or_create_by(name: row[0])
        City.find_or_create_by(name: row[1], state: state)
      end
    end

    desc 'Populate regions, states, and cities and scholarities'
    task institutions: :environment do
      CSV.foreach('./lib/tasks/seeds/data/institutions.csv') do |row|
        city = City.joins(:state).find_by(name: row[2], states: { acronym: row[3] })

        Institution.create_with(city: city).find_or_create_by(name: row[0], acronym: row[1])
      end

      CSV.foreach('./lib/tasks/seeds/data/scholarities.csv') do |row|
        Scholarity.create(name: row[0], abbr: row[1])
      end
    end
  end
end
