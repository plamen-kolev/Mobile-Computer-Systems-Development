class ConversationsController < ApplicationController

  before_action :authenticate_user! # , :except => [:show, :index]

  def create
    recipient = User.find(params[:user_id])
    receipt = current_user.send_message(recipient, 'hello', 'chat')
    redirect_to conversation_path(receipt.conversation)
  end

  def show
    connection = Connection.where(channel: params[:channel]).first
    if ! (connection.follower_id == current_user.id or connection.followee_id == current_user.id)
      raise "You are not associated with this conversation"
    end
    @channel = connection.channel
  end

  def new
    connection = Connection.find(params[:connection])
    ip_messaging_client = Twilio::REST::IpMessagingClient.new(ENV['API_KEY_SID'], ENV['API_KEY_SECRET'])

    # Create the channel
    service = ip_messaging_client.services.get(ENV['IPM_SERVICE_SID'])

    channel = service.channels.create()

    connection.channel = channel.sid
    connection.save()
    redirect_to root_path

  end

  def update_last_read()
    params.permit(:channel, :message_index)
    sid = params[:channel]
    mindex = params[:message_index]

    raise "Value error" if not sid
    raise "Value error " if not mindex

    c = Connection.where(channel: sid).first
    raise "Unable to find entity" if not c

    cuser = current_user
    if c.follower_id == current_user.id
      c.follower_lastread_index = mindex
      c.follower_lastread_ts = Time.now.utc.iso8601
    else
      c.followee_lastread_index = mindex
      c.followee_lastread_ts = Time.now.utc.iso8601
    end
    c.save()
  end

end
