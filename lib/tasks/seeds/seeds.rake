require 'csv'

# From:
# ftp://geoftp.ibge.gov.br/organizacao_do_territorio/estrutura_territorial/divisao_territorial/2018/
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
  end
end
