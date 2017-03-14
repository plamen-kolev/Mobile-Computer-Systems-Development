namespace :faker do
  desc "TODO"
  task init: :environment do
    Rake::Task['db:purge'].invoke
    Rake::Task['db:migrate'].invoke
    User.create(:email => "local@host", :password => 'password', :password_confirmation => 'password')
    User.create(:email => "user2@host", :password => 'password', :password_confirmation => 'password')

    (0..20).each do |i|
      User.create(:email => "#{Faker::Internet.email}", :password => 'password', :password_confirmation => 'password')
    end


    (0..80).each do |i|
      action = Message.create(user_id: rand(1..2), conversation_id:2, body: Faker::Hipster.paragraph)
    end
  end
end