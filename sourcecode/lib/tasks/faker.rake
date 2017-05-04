namespace :faker do
  desc "TODO"
  task init: :environment do
    Rake::Task['db:purge'].invoke
    Rake::Task['db:migrate'].invoke
    User.create(:email => "local@host.com", :password => 'password', :password_confirmation => 'password')
    User.create(:email => "user2@host.com", :password => 'password', :password_confirmation => 'password')

    (0..2).each do |i|
      User.create(:email => "user#{3+i}@host.com", :password => 'password', :password_confirmation => 'password')
    end

  end
end
