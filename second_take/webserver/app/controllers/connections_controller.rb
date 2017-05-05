class ConnectionsController < ApplicationController
  before_action :authenticate_user

  def users
    blacklisted_ids = [current_user.id]
    users = User.all.reject { |u| blacklisted_ids.include?(u.id) }
    render json: users
  end

  def confirm
    params.require(:user_id)
    confirmee = User.find(params[:user_id])
    puts confirmee.email
    puts current_user.email
    connection = Connection.where(r_id: current_user.id, confirmed: false, l_id: confirmee.id).first()

    if not connection
      render :text => "Not found", :status => 404
      return
    end
    connection.confirmed = true
    connection.save()
  end

  def index
    # render json: current_user
    connections = Connection.where(l_id: current_user.id).or(Connection.where(r_id: current_user.id))
    render json: connections.map{|c|
      id = -1
      if c.r_id == current_user.id; id=c.l_id else id=c.r_id end
      {
        channel: c.channel,
        recipient: User.find(id).email,
        confirmed: c.confirmed
      }
    }
  end

  def create
    params.require(:user_id)

    l =  User.find(current_user.id)
    r = User.find(params[:user_id])

    Connection.connect(l,r)
    # Connection.create(channel: channel, confirmed: false, l_id:l.id, r_id: r.id)
  end

  # messeging features
  def send_message
    params.require(:channel_id, :recipient, :body)
    puts Connection::get(current_user).inspect
  end

  def show
    c = Connection::where(channel: params[:id], confirmed: true).first()

    puts c.inspect
    if not c
      render html: "Friendship not accepted yet", :status => 404
      return
    end

    unless (c.r_id == current_user.id or c.l_id == current_user.id)
      render html: "Not found", :status => 404
    end

    messages = Message::messages(c)
    render json: messages
  end

end
