namespace :db do
  desc 'Setup initial database to development'

  task setup_db_dev: :environment do
    call_setup_database
    call_migrate
    call_seeds
  end

  def call_setup_database
    puts 'Running drop database. . . '
    Rake::Task['db:drop'].invoke
    puts 'Running create database'
    Rake::Task['db:create'].invoke
  end

  def call_migrate
    puts 'Running migrate'
    Rake::Task['db:migrate'].invoke
    puts '. . .Finish process ✔'
  end

  def call_seeds
    puts 'Running seed'
    Rake::Task['db:seed'].invoke
    puts 'call populate'
    Rake::Task['db:populate'].invoke
    puts '. . .Finish process ✔'
  end
end
