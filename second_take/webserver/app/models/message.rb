class Message < ApplicationRecord
  belongs_to :users, :primary_key => :recipient, foreign_key: 'recipient_id'
  belongs_to :users, :primary_key => :sender, foreign_key: 'sender_id'
  belongs_to :connection

  def self.messages(connection)
    msgs = Message.where(connection_id: connection.id).order(created_at: :asc)
    return msgs.map{|m|
      {
        body: m.body,
        room: connection.channel,
        sender: User.find(m.sender_id).email,
        recipient: User.find(m.recipient_id).email,
        date: m.created_at,
        id: m.id
      }
    }
  end

  def to_json
    return {
      body: self.body,
      room: Connection.where(id: self.connection_id).first().channel,
      sender: User.find(self.sender_id).email,
      recipient: User.find(self.recipient_id).email,
      date: self.created_at,
      id: self.id
    }
  end
end
