class Connection < ApplicationRecord
  belongs_to :users, :primary_key => :id, foreign_key: 'l_id'
  belongs_to :users, :primary_key => :id, foreign_key: 'r_id'

  def self.get(participant, is_confirmed = true)
    return Connection.where(r: participant, confirmed: is_confirmed, l: current_user).or(Connection.where(l: participant, confirmed: is_confirmed, r: current_user))
  end

  def to_json(current_user)
    id = -1
    if self.r_id == current_user.id; id = self.l_id else id = self.r_id end
    {
      channel: self.channel,
      recipient: User.find(id).email,
      confirmed: self.confirmed
    }
  end

  def self.to_json(current_user)
    connections = Connection.where(l_id: current_user.id).or(Connection.where(r_id: current_user.id))
    return connections.map{|c|
      id = -1
      if c.r_id == current_user.id; id=c.l_id else id=c.r_id end
      {
        channel: c.channel,
        recipient: User.find(id).email,
        confirmed: c.confirmed
      }
    }
  end

  def self.connect(l,r)

    # cannot add self as friend
    return if l == r

    # check if already connected
    connection = Connection.where(r_id: r.id, l_id: l.id)
                .or(Connection.where(l_id: l.id, r_id: r.id)).first

    return if connection

    #otherwise create one
    # channel = Digest::SHA256.hexdigest (r.email + l.email)
    channel = [
      Faker::Color.color_name,
      Faker::Color.color_name,
      Faker::Color.color_name,
      Faker::Color.color_name,
      Faker::Color.color_name
    ].join('-').parameterize

    return Connection.create(channel: channel, confirmed: false, l_id:l.id, r_id: r.id)
  end
end
