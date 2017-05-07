class Connection < ApplicationRecord
  belongs_to :users, :primary_key => :id, foreign_key: 'l_id'
  belongs_to :users, :primary_key => :id, foreign_key: 'r_id'

  def self.get(participant, is_confirmed = true)
    return Connection.where(r: participant, confirmed: is_confirmed, l: current_user).or(Connection.where(l: participant, confirmed: is_confirmed, r: current_user))
  end

  def to_json(current_user)
    id = -1
    karma = -1
    if self.r_id == current_user.id
       id = self.l_id
       karma = self.r_karma
    else
      id = self.r_id
      karma = self.l_karma
    end

    return {
      channel: self.channel,
      recipient: User.find(id).email,
      confirmed: self.confirmed,
      karma: karma,
      status: self._get_status(current_user)
    }
  end

  def self.to_json(current_user)
    connections = Connection.where(l_id: current_user.id).or(Connection.where(r_id: current_user.id))
    return connections.map{|c|
      id = -1

      karma = -1
      if c.r_id == current_user.id
         id = c.l_id
         karma = c.l_karma
      else
        id = c.r_id
        karma = c.l_karma
      end

      recipient = User.find(id)
      {
        channel: c.channel,
        recipient: recipient.email,
        user_id: recipient.id,
        confirmed: c.confirmed,
        karma: karma,
        status: c._get_status(current_user)

      }
    }
  end

  def _get_status(current_user)
    status = ''
    if self.confirmed
      status = 'confirmed'
      # if you are on the left side of the relationship, pending
    elsif self.l_id == current_user.id
      status = 'pending'
  # if you are on the right side of the relationship, enable confirming
  elsif self.r_id == current_user.id
      status = 'confirm'
    end
    return status
  end

  def self.connect(l,r)

    # cannot add self as friend
    return if l == r

    # check if already connected
    connection = Connection.where(r_id: r.id, l_id: l.id)
                .or(Connection.where(l_id: l.id, r_id: r.id)).first

    return connection if connection

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
