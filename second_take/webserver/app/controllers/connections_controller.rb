
class ConnectionsController < ApplicationController

  before_action :authenticate_user
  before_action :get_connection, only: [:show, :send_message, :message, :show_messages, :send_rude]

  def users
    blacklisted_ids = [current_user.id]
    users = User.all.reject { |u| blacklisted_ids.include?(u.id) }
    render json: users
  end

  def confirm
    params.require(:user_id)
    confirmee = User.find(params[:user_id])
    connection = Connection.where(r_id: current_user.id, confirmed: false, l_id: confirmee.id).first()

    render :text => "Not found", :status => 404; return if not connection

    connection.confirmed = true
    connection.save()
  end

  def index
    # renders all accepted friends
    render json: Connection::to_json(current_user)
  end

  def create
    params.require(:user_id)

    l =  User.find(current_user.id)
    r = User.find(params[:user_id])

    Connection.connect(l,r)
  end

  def message
    params.require(:message_id)
    message = Message.where(connection_id: @connection.id, id: params[:message_id].to_i).first()

    if message
      render json: message.to_json
    else
      render json: {status: 404}, status: 404
    end
  end

  # messeging features
  def send_message
    params.require(:body)
    recipient_id = @connection.r_id == current_user.id ? @connection.l_id : @connection.r_id
    m = message = Message.create(
      sender_id: current_user.id,
      recipient_id: recipient_id,
      body: ActionController::Base.helpers.sanitize(params[:body]),
      connection_id: @connection.id
    )
    render json: m.to_json if message
  end

  def show
    render json: @connection.to_json(current_user)
  end

  def show_messages
    # exit if no friendship accepted
    if not @connection
      render json: {status: "not found"}, :status => 404
      return
    end
    unless (@connection.r_id == current_user.id or @connection.l_id == current_user.id)
      render json: {status: "Not found"}, :status => 404
      return
    end

    messages = Message::messages(@connection)
    render json: messages
  end

  def send_rude
    params.require(:emoticon)
    emoticons = get_rude_emoticons()
    # emoticon_cost = emoticons[emoticons.index params[:emoticon]].cost

    cost = 0
    emoticons.each do |e|
      puts e
      if e[:code] == params[:emoticon]
        cost = e[:cost]
      end
    end

    # find out who you are in the connection relationship
    if @connection.l_id == current_user.id
      if @connection.l_karma < cost
        render json: {status: "Not enough karma"}, :status => 400
      else
        @connection.l_karma -= cost
        @connection.save()
        render json: {karma: @connection.l_karma, karma_before: @connection.l_karma + cost}
      end
    else
      if @connection.r_karma < cost
        render json: {status: "Not enough karma"}, :status => 400
      else
        @connection.r_karma -= cost
        @connection.save()
        render json: {karma: @connection.r_karma, karma_before: @connection.r_karma + cost}
      end
    end

  end

  private
    def get_connection
      params.require(:connection_id)
      @connection = Connection::where(channel: params[:connection_id], confirmed: true, r_id: current_user).or(Connection::where(channel: params[:connection_id], confirmed: true, l_id: current_user)).first()
    end

end
