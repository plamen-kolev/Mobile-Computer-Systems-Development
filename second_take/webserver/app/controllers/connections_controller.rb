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

    connections = Connection.where(l_id: current_user.id).or(Connection.where(r_id: current_user.id))
    render json: connections
  end

  def create
    params.require(:user_id)

    l =  User.find(current_user.id)
    r = User.find(params[:user_id])

    channel = Digest::SHA256.hexdigest (r.email + l.email)
    puts channel
    Connection.create(channel: channel, confirmed: false, l_id:l.id, r_id: r.id)
  end

end
