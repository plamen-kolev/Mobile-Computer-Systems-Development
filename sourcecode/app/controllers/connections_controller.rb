class ConnectionsController < ApplicationController
  before_action :authenticate_user! # , :except => [:show, :index]

  def create
    Connection.create(follower_id: current_user.id, followee_id: params[:connection][:followee_id])
  end

  def index
    @pending = Connection.where(followee_id: current_user, confirmed: false)

    # exclude self and pending
    # sending fr request does not make sense
    blacklisted_ids = [current_user.id]
    @pending.each do |p|
      blacklisted_ids.push(p.follower_id)
    end

    @people = User.all.reject { |u| blacklisted_ids.include?(u.id) }
    @connection = Connection.new
  end

  def confirm
    follower_id = params[:connections_confirm][:id].to_i
    c = Connection.where(follower_id: follower_id, followee_id: current_user.id).first
    c.confirm()
    redirect_to :back
  end

end
