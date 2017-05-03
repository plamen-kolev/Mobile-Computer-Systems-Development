namespace :faker do
  desc "TODO"
  task init: :environment do
   Rake::Task['db:purge'].invoke
   Rake::Task['db:migrate'].invoke

    # create user
    User.create(email: 'local@host.com', name: 'Plamen', password: "password")
    User.create(email: 'local2@host.com', name: 'Plamen', password: "password")

  end

end
