namespace :db do
  desc 'Erase and fill database'

  task populate: :environment do
    delete_all
    seeds
  end

  def seeds
    Rake::Task['db:seeds:cities'].invoke
    Rake::Task['db:seeds:institutions'].invoke
  end

  def delete_all
    [Institution].each(&:delete_all)
    Admin.where.not(email: 'admin@admin.com').destroy_all
  end
end
