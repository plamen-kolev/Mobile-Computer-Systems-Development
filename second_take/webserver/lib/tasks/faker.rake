namespace :faker do
  desc "TODO"
  task init: :environment do
   Rake::Task['db:purge'].invoke
   Rake::Task['db:migrate'].invoke

    # create user
    u1 = User.create(email: 'local@host.com', name: 'Plamen', password: "password")
    u2 = User.create(email: 'local1@host.com', name: 'Plamen', password: "password")
    for i in 2..5
      User.create(email: "local#{i}@host.com", name: 'John', password: "password")
    end

    # this is the sample case
    c = Connection.connect(u1,u2)
    c.confirmed = true
    c.save()

    # create fake friendships
    for i in 1..20
      c = Connection.connect(User.all.sample(), User.all.sample())
      if rand(2) == 1 and c
        c.confirmed = true
        c.save
      end
    end

    # create fake messages for each connection
    connections = Connection.where(confirmed: true)
    connections.each do | connection |
      for i in 0..5
        # pick at random who sends and who receives, e.g. either pop or shift
        participants = [connection.r_id, connection.l_id]
        sender_id = -1
        reciever_id = -1
        if rand(2) == 1
          sender_id = participants.shift()
        else
          sender_id = participants.pop()
        end
        reciever_id = participants.pop()
        Message.create(sender_id: sender_id, recipient_id: reciever_id, body: Faker::Lorem.paragraph(1), connection_id: connection.id)
      end
    end

  end

end
